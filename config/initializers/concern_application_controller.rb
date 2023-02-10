require 'active_support/concern'

module ConcernApplicationController
  extend ActiveSupport::Concern
  
  included do
    protect_from_forgery prepend: true
    
    rescue_from CanCan::AccessDenied do |exception| 
      redirect_to main_app.root_url, alert: exception.message 
    end
    
    before_action :store_user_location!, if: :storable_location?
    before_action :reject_locked!, if: :devise_controller?
    
    # Redirects on successful sign in
    def after_sign_in_path_for resource
      root_actions = RailsAdmin::Config::Actions.all(:root).select {|action| can? action.action_name, :all }.collect(&:action_name)
      
      # Default root action as landing page: the first to which I have authorization to read
      action = root_actions.first
      puts "after_sign_in_path_for action: #{action}"
      # Otherwise, if I set a Manual override for landing actions in config, I can test if I'm authorized to see it
      override_landing_page = Settings.ns(:main).after_sign_in_redirect_to_root_action
      action = override_landing_page.to_sym if !override_landing_page.blank? && root_actions.include?(override_landing_page.to_sym)
      
      # If I ask for a specific page, Let's try to go back there if I need to login or re-login
      # This takes precedence on automatic computed action
      stored_location = stored_location_for(resource)
      puts "after_sign_in_path_for stored_location: #{stored_location}"
      if !stored_location.blank? && can?(resource, :all)
        # Go to the latest navigated page
        puts "after_sign_in_path_for Redirect to stored_location"
        return stored_location
      elsif action
        path = rails_admin.send("#{action}_path").sub("#{ENV['RAILS_RELATIVE_URL_ROOT']}#{ENV['RAILS_RELATIVE_URL_ROOT']}", "#{ENV['RAILS_RELATIVE_URL_ROOT']}")
        puts "after_sign_in_path_for Redirect to action #{path}"
        return path
      else
        puts "after_sign_in_path_for ERROR! Signing out user :-("
        sign_out current_user
        user_session = nil
        current_user = nil
        flash[:alert] = "Your user is not authorized to access any page."
        flash[:notice] = nil
        return root_path
      end
    end
    
    # Auto-sign out locked users
    def reject_locked!
      if !current_user.blank? && current_user.locked?
        puts " - Cleaning session"
        sign_out current_user
        user_session = nil
        current_user = nil
        flash[:alert] = "Your account is locked."
        flash[:notice] = nil
        redirect_to root_url
      end
    end
    
    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as 
    #     Devise::SessionsController as that could cause an 
    #     infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected 
    #     behaviour.
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end
    
    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end
  end
end
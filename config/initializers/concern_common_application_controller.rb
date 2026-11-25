puts "CommonApplicationController Concern from ThecoreUiCommons"
require 'active_support/concern'

module ConcernCommonApplicationController
  extend ActiveSupport::Concern
  
  included do
    # protect_from_forgery prepend: true
    protect_from_forgery prepend: true
    
    rescue_from CanCan::AccessDenied do |exception| 
      redirect_to main_app.root_url, alert: exception.message 
    end
    
    before_action :store_user_location!, if: :storable_location?

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
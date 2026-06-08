Rails.application.routes.draw do
    scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
        controllers = {
            sessions: "users/sessions"
        }
        controllers[:omniauth_callbacks] = 'users/omniauth_callbacks' if ThecoreAuthCommons.respond_to?(:oauth_vars?) && ThecoreAuthCommons.oauth_vars?
        devise_for :users, controllers: controllers
    end
    
    devise_scope :user do
        scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
            root to: "devise/sessions#new"
        end
    end

    scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
        get '/info/swagger', to: redirect { |_params, req| "#{req.path}/v2" }
        get '/info/swagger/:version', to: 'info#swagger'
    end
end
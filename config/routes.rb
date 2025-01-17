Rails.application.routes.draw do
    scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
        devise_for :users
    end
    
    devise_scope :user do
        scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
            root to: "devise/sessions#new"
        end
    end

    scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
        get '/info/swagger', to: 'info#swagger'
    end
end
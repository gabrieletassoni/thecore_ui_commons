Rails.application.routes.draw do
    scope ENV.fetch("RAILS_RELATIVE_URL_ROOT", "/") do
        devise_for :users
        devise_scope :user do
            root to: "devise/sessions#new"
        end

        get '/info/swagger', to: 'info#swagger'
    end
end
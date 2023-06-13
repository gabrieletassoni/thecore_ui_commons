Rails.application.configure do
    config.after_initialize do
        # Controllers
        ApplicationController.send :include, ConcernApplicationController
        RailsAdmin::ApplicationController.send :include, ConcernApplicationController
        User.send(:include, ThecoreUiCommonsUserConcern)
    end
end
Rails.application.configure do
    config.after_initialize do
        # Controllers
        ApplicationController.send(:include, ConcernCommonApplicationController)
        User.send(:include, ThecoreUiCommonsUserConcern)
        RailsAdmin::ApplicationController.send(:include, ConcernCommonApplicationController)
    end
end
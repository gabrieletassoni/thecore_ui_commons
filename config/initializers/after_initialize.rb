Rails.application.configure do
    config.after_initialize do
        # Controllers
        ApplicationController.send(:include, ConcernCommonApplicationController)
    end
end
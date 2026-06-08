module ThecoreUiCommons
  class Engine < ::Rails::Engine
    config.after_initialize do
      ThecoreUiCommons.swagger_api_versions = ThecoreUiCommons.scan_swagger_routes(
        Rails.application.routes.routes
      )
    end
  end
end

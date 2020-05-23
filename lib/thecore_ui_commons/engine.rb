require 'helpers/thecore_ui_commons_helper'
require 'helpers/charts_helper'
module ThecoreUiCommons
  class Engine < ::Rails::Engine
    initializer "thecore_ui_commons.view_helpers" do
      ActiveSupport.on_load(:action_view) { include Helpers::ThecoreUiCommonsHelper }
      ActiveSupport.on_load(:action_view) { include Helpers::ChartsHelper }
    end

    initializer 'thecore_ui_commons.add_to_migrations' do |app|
      unless app.root.to_s.match root.to_s
        # APPEND TO MAIN APP MIGRATIONS FROM THIS GEM
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end

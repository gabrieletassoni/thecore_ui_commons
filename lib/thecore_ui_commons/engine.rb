module ThecoreUiCommons
  class Engine < ::Rails::Engine
    initializer 'thecore_ui_commons.add_to_migrations' do |app|
      # Adds the list of Thecore Engines, so to manage seeds loading, i.e.:
      Thecore::Base.thecore_engines << self.class
      unless app.root.to_s.match root.to_s
        # APPEND TO MAIN APP MIGRATIONS FROM THIS GEM
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end

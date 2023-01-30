Rails.application.configure do
    config.assets.precompile += %w( thecore_ui_commons_manifest.js )
end

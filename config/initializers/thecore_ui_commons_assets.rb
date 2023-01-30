Rails.application.configure do
    config.assets.precompile += %w( thecore_ui_commons_manifest.js )
    config.assets.precompile += %w( android-chrome-192x192.png android-chrome-512x512.png )
    config.assets.precompile += %w( devise/sessions.css devise/sessions.js )
end

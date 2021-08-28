Rails.application.config.assets.configure do |env|
    env.export_concurrent = false
end

Rails.application.config.assets.precompile += %w( thecore_ui_commons/thecore-devise.js )
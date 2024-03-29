Rails.application.config.filter_parameters += [:password]

Rails.application.config.active_record.raise_in_transactional_callbacks = true

Rails.application.config.serviceworker.routes.draw do
    match "/manifest.json"
end

Rails.application.config.assets.configure do |env|
    env.export_concurrent = false
end


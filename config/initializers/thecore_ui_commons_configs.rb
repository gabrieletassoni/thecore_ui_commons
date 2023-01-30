Rails.application.configure do
    config.filter_parameters += [:password]
    
    config.active_record.raise_in_transactional_callbacks = true
    
    config.serviceworker.routes.draw do
        match "/manifest.json"
    end
    
    config.assets.configure do |env|
        env.export_concurrent = false
    end
    
    config.after_initialize do
        User.send(:include, ThecoreUiCommonsUser)
    end
end

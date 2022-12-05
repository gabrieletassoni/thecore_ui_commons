Rails.application.config.assets.configure do |env|
    env.export_concurrent = false
    # env.js_compressor  = :uglifier # or :closure, :yui
    # env.css_compressor = :sass   # or :yui
end

Rails.application.config.assets.precompile += %w( thecore_ui_commons/thecore-devise.js )
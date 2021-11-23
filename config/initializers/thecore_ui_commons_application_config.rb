Rails.application.configure do
  config.assets.precompile += %w( favicon.ico )
  config.assets.precompile += %w( apple-touch-icon.png )
  config.assets.precompile += %w( favicon-32x32.png )
  config.assets.precompile += %w( favicon-16x16.png )
  config.assets.precompile += %w( safari-pinned-tab.svg )
  config.assets.precompile += %w( mstile-150x150.svg )
  config.assets.precompile += %w( android-chrome-192x192.png )
  config.assets.precompile += %w( android-chrome-512x512.png )
  config.assets.precompile += %w( logo.png )
  config.assets.precompile += %w( customer_logo.png )
  config.assets.precompile += %w( up-arrow.png )
  config.assets.precompile += %w( thecore.js )
  config.assets.precompile += %w( thecore.css )
  config.assets.precompile += %w( ie.js )
  config.assets.precompile += %w( manifest.json )
  config.assets.precompile += %w( browserconfig.xml )
  config.assets.precompile += %w( thecore_ui_commons/thecore.js )
  config.assets.precompile += %w( thecore_ui_commons/thecore.css )
  # Very important, needed for trix (i.e.)
  config.assets.paths << root.join('node_modules')
  # To store D3 Data
  # https://medium.com/@hguotblog/use-d3-js-for-data-visualisation-with-rails-69b4f030e366
  config.assets.paths << root.join('data')
  # Putting also a reference on the assets foldes in the paths, so to have the 
  # stylesheet and javascript hack work proprly in layout
  # config.assets.paths << 
  # root.join("app", "assets", "stylesheets", "thecore_ui_commons")
  # config.assets.paths << 
  # root.join("app", "assets", "javascripts", "thecore_ui_commons")
  # config.action_controller.asset_host = if ENV['RAILS_URL'].blank? || ENV['RAILS_RELATIVE_URL_ROOT'].blank?
  #   "http://localhost:3000"
  # else
  #   "#{ENV['RAILS_URL']}#{ENV['RAILS_RELATIVE_URL_ROOT']}"
  # end
  
  config.filter_parameters += [:password]
  
  config.active_record.raise_in_transactional_callbacks = true
  
  config.serviceworker.routes.draw do
    match "/manifest.json"
  end
  
  config.after_initialize do
    User.send(:include, ThecoreUiCommonsUser)
  end
end

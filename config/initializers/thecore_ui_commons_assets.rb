Rails.application.configure do
    config.assets.precompile += %w( 
        android-chrome-192x192.png 
        android-chrome-512x512.png 
        apple-touch-icon.png
        favicon.ico
        customer_logo.png
        logo.png
    )
    config.assets.precompile += %w( devise/sessions.css devise/sessions.js )
end

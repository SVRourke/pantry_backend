# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors
# REQUIRES ENV VAR ORIGIN
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV["ORIGIN"]
    resource('*', headers: :any, methods: :any, credentials: true)
    end
end
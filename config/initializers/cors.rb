# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'localhost:8085' # Origen desde el que se permitirán las solicitudes CORS
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
end
  
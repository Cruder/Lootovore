# frozen_string_literal: true

require 'hanami/middleware/body_parser'
require 'rack/cors'

module Web
  def self.app
    Rack::Builder.new do
      use Rack::Cors do
        allow do
          origins '*'
          resource '*',
                   methods: %i[get post delete put patch options head],
                   headers: :any,
                   max_age: 600
        end
      end
      use Hanami::Middleware::BodyParser, :json
      run Router
    end
  end
end

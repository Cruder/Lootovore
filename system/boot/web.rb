# frozen_string_literal: true

Loot::Application.boot(:web) do |_app|
  init do
    require 'hanami-router'
    require 'hanami-controller'
  end

  start do
    Hanami::Controller.configure do
      default_request_format :json
      default_response_format :json
    end
  end
end

# frozen_string_literal: true

module Loot
  module Web
    Router = Hanami::Router.new do
      get '/loots', to: Controllers::Loots::Index
      get '/characters', to: Controllers::Characters::Index
      get '/characters/:id', to: Controllers::Characters::Show
    end
  end
end

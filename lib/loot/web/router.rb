# frozen_string_literal: true

module Loot
  module Web
    Router = Hanami::Router.new do
      root to: Controllers::Root::Index

      get '/loots', to: Controllers::Loots::Index
      get '/characters', to: Controllers::Characters::Index
      get '/characters/:id', to: Controllers::Characters::Show

      get '/equipments/:id', to: Controllers::Equipments::Show
    end
  end
end

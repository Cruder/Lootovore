# frozen_string_literal: true

module Loot
  module Web
    Router = Hanami::Router.new do
      get '/', to: Controllers::Root::Index
    end
  end
end

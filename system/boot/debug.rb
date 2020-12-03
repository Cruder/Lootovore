# frozen_string_literal: true

Loot::Application.boot(:debug) do
  init do
    require 'pry'
    require 'pry-byebug'
  end
end

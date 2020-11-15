# frozen_string_literal: true

Loot::Application.boot(:persistence) do |app|
  start do
    register('container', ROM.container(app['db.config']))
  end
end

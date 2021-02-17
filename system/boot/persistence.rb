# frozen_string_literal: true

Assistant::Application.boot(:persistence) do |app|
  start do
    config = app['db.config']
    config.auto_registration("#{app.root}/lib/loot")

    register('container', ROM.container(app['db.config']))
  end
end

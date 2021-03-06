# frozen_string_literal: true

Assistant::Application.boot(:db) do
  init do
    require 'rom'
    require 'rom-sql'
    require 'rom/sql/extensions/postgres'

    connection = Sequel.connect(ENV['DATABASE_URL'], extensions: %i[pg_timestamptz])

    register('db.connection', connection)
    register('db.config', ROM::Configuration.new(:sql, connection))
  end
end

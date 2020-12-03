# frozen_string_literal: true

require_relative 'config/application'
require 'rom-sql'
require 'rom/sql/rake_task'

namespace :db do
  desc ''
  task :setup do
    Loot::Application.start(:db)
    config = Loot::Application['db.config']
    config.gateways[:default].use_logger(Logger.new($stdout))
  end
end

namespace :loots do
  desc 'load all loots into the database'
  task :import, [:filename] do |_t, args|
    Loot::Application.finalize!

    data = JSON.parse(File.read(args[:filename]))

    Loot::Attribution::Imports::RcLootCouncilImporter.new.from_json(data)
  end
end

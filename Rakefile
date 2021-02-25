# frozen_string_literal: true

require_relative 'config/application'
require 'rom-sql'
require 'rom/sql/rake_task'

namespace :db do
  desc ''
  task :setup do
    Assistant::Application.start(:db)
    config = Assistant::Application['db.config']
    config.gateways[:default].use_logger(Logger.new($stdout))
  end
end

namespace :loots do
  desc 'load all loots into the database'
  task :import, [:filename] do |_t, args|
    Assistant::finalize_application!

    data = JSON.parse(File.read(args[:filename]))

    Loot::Attribution::Imports::RcLootCouncilImporter.new.from_json(data)
  end
end

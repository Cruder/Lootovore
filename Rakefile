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

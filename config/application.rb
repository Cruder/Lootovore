# frozen_string_literal: true

require_relative 'boot'

require 'dry/system/container'
require 'dry/auto_inject'
require 'dry/monitor'

module Assistant
  class Application < Dry::System::Container
    use :env, inferrer: -> { ENV.fetch('APP_ENV', :development).to_sym }
    use :logging
    use :notifications

    setting :logger_class, Dry::Monitor::Logger

    configure do |config|
      config.root = File.expand_path('..', __dir__)

      config.component_dirs.add 'lib' do |dir|
        dir.auto_register = true
        dir.add_to_load_path = true
        dir.default_namespace = 'loot'
      end

      config.component_dirs.add 'apps' do |dir|
        dir.auto_register = true
        dir.add_to_load_path = true
      end
    end

    after(:configure) do
      register(:rack_monitor, Monitor::Rack::Middleware.new(self[:notifications]))
      rack_logger = Monitor::Rack::Logger.new(self[:logger])
      rack_logger.attach(self[:rack_monitor])
    end

    add_to_load_path!('lib', 'apps/web')
  end

  Import = Dry::AutoInject(Application)

  def self.finalize_application!
    Assistant::Application.finalize!
    Assistant::Application.require_from_root("lib/loot/**/*.rb")
    Assistant::Application.require_from_root("apps/web/**/*.rb")
  end
end

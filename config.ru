# frozen_string_literal: true

require_relative 'config/application'

Assistant::Application.finalize!
Assistant::Application.require_from_root("lib/loot/**/*.rb")
Assistant::Application.require_from_root("apps/web/**/*.rb")

run Web.app

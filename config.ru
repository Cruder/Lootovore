# frozen_string_literal: true

require_relative 'config/application'

Loot::Application.finalize!

run Loot::Web.app

# frozen_string_literal: true

module Loot
  module Web
    module Controllers
      module Loots
        class Imports
          include Hanami::Action

          format 'json'

          configuration do
            default_response_format :json
          end

          def call(_params)
            if password == ENV['TITAN_PASSWORD']
              Loot::Attribution::Imports::RcLootCouncilImporter.new.from_json(data)

              self.body = '{}'
              self.status = 200
            else
              self.status = 403
              self.body = { error: :unauthorized }
            end

            self.format = :json
          end

          private

          def data
            params
              .to_h[:loots]
              .map { |loot_hash| loot_hash.transform_keys { |key| key.to_s } }
          end

          def password
            params.to_h[:password]
          end
        end
      end
    end
  end
end

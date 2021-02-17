# frozen_string_literal: true

module Web
  module Controllers
    module Loots
      class Index
        include Hanami::Action
        include Assistant::Import['repos.loot_repo']

        format 'json'

        configuration do
          default_response_format :json
        end

        def call(_params)
          loots = loot_repo.all

          loot_serializer = Serializers::LootSerializer.new

          self.format = :json
          self.body = loot_serializer.serialize_multi(loots).to_json
          self.status = 200
        end
      end
    end
  end
end

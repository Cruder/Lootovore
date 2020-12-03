# frozen_string_literal: true

module Loot
  module Web
    module Controllers
      module Characters
        class Show
          include Hanami::Action
          include Import['repos.character_repo']

          format 'json'

          configuration do
            default_response_format :json
          end

          def call(params)
            character = character_repo.by_id(params[:id])

            character_serializer = Serializers::CharacterSerializer.new

            self.format = :json
            self.body = character_serializer.serialize(character).to_json
            self.status = 200
          end
        end
      end
    end
  end
end

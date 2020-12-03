# frozen_string_literal: true

module Loot
  module Web
    module Controllers
      module Characters
        class Index
          include Hanami::Action
          include Import['repos.character_repo']

          format 'json'

          configuration do
            default_response_format :json
          end

          def call(params)
            klasses = params.to_h[:klasses]&.map(&:upcase) || []
            characters = character_repo.all(klasses: klasses)

            character_serializer = Serializers::CharactersSerializer.new

            self.format = :json
            self.body = character_serializer.serialize(characters).to_json
            self.status = 200
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Loot
  module Web
    module Serializers
      class CharacterSerializer
        include Import['web.serializers.loot_serializer']

        def serialize(character)
          {
            id: character.id,
            name: character.name,
            klass: character.klass,
            icon: character.icon
          }.merge(loots_data(character))
        end

        private

        def loots_data(character)
          loots = character.loots.map { |loot| loot_serializer.serialize(loot) }

          {
            loots: loots
          }
        end
      end
    end
  end
end

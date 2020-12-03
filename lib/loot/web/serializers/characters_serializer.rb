# frozen_string_literal: true

module Loot
  module Web
    module Serializers
      class CharactersSerializer
        include Import['web.serializers.loot_serializer']

        def serialize(characters)
          characters.map { serialize_one(_1) }
        end

        private

        def serialize_one(character)
          {
            id: character.id,
            name: character.name,
            klass: character.klass,
            icon: character.icon,
            loot_count: loot_count(character),
            loots: character.loots.map { |loot| loot_serializer.serialize(loot) }
          }.merge(loots_data(character))
        end

        def loots_data(character)
          data = character.loots.first ? loot_serializer.serialize(character.loots.first) : nil

          {
            last_loot: data
          }
        end

        def loot_count(character)
          {
            1 => 0,
            2 => 0,
            3 => 0,
            4 => 0,
            5 => 0,
            6 => 0
          }.merge(character.loots.group_by { |loot| loot.wish.rank }.transform_values(&:size))
        end
      end
    end
  end
end

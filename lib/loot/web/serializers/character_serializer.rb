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
            icon: character.icon,
            loot_count: loot_count(character),
            loots: loots(character)
          }
        end

        private

        def loots(character)
          character
            .loots
            .sort_by { |loot| loot.wish.rank }
            .group_by { |loot| loot.wish.name }
            .transform_values { |loots| loots.sort_by(&:date).reverse }
            .transform_values { |loots| loots.map { |loot| loot_serializer.serialize(loot) } }
        end

        def loot_count(character)
          character
            .loots
            .group_by { |loot| loot.wish.rank - 1 }
            .transform_values(&:size)
            .each_with_object(Array.new(6)) { |(k, v), acc| acc[k] = v }
            .map { |v| v || 0 }
        end
      end
    end
  end
end

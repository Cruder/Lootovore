# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

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
            loots: loots(character)
          }
        end

        def loots(character)
          character
            .loots
            .select { |loot| loot.wish.rank <= 2 }
            .map { |loot| loot_serializer.serialize(loot) }
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

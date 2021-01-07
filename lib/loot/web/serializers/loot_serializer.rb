# frozen_string_literal: true

module Loot
  module Web
    module Serializers
      class LootSerializer
        include Import['web.serializers.leaf.character_serializer']
        include Import['web.serializers.leaf.equipment_serializer']

        def serialize_multi(loots)
          loots.map { serialize(_1) }
        end

        def serialize(loot)
          {
            wish: loot.wish.name,
            wish_rank: loot.wish.rank,
            date: loot.date.iso8601,
            nb_vote: loot.nb_vote
          }.merge(
            character_data(loot),
            equipment_data(loot)
          )
        end

        private

        def character_data(loot)
          if loot.respond_to?(:character)
            {
              character: character_serializer.serialize(loot.character)
            }
          else
            {
              character_id: loot.character_id
            }
          end
        end

        def equipment_data(loot)
          if loot.respond_to?(:equipment)
            {
              equipment: equipment_serializer.serialize(loot.equipment)
            }
          else
            {
              equipment_id: loot.equipment_id
            }
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Web
  module Serializers
    class EquipmentSerializer
      include Assistant::Import['web.serializers.loot_serializer']

      def serialize_multi(equipments)
        equipments.map { serialize(_1) }
      end

      def serialize(equipment)
        {
          id: equipment.id,
          name: equipment.name,
          icon: equipment.icon_url,
          quality: equipment.quality,
          wowhead_url: equipment.wowhead_url,
          item_id: equipment.item_id,
          loots: loots(equipment)
        }
      end

      def loots(equipment)
        equipment
          .loots
          .sort_by { |loot| loot.wish.rank }
          .group_by { |loot| loot.wish.name }
          .transform_values { |loots| loots.sort_by(&:date).reverse }
          .transform_values { |loots| loots.map { |loot| loot_serializer.serialize(loot) } }
      end
    end
  end
end

# frozen_string_literal: true

module Loot
  module Web
    module Serializers
      module Leaf
        class EquipmentSerializer
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
              item_id: equipment.item_id
            }
          end
        end
      end
    end
  end
end

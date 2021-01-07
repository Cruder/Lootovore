# frozen_string_literal: true

module Loot
  module Repos
    class EquipmentRepo < ROM::Repository[:equipments]
      struct_namespace ::Loot::Entities

      include Import['container']

      commands :create,
               use: :timestamps,
               plugins_options: {
                 timestamps: {
                   timestamps: %i[created_at updated_at]
                 }
               }

      def by_id(id)
        equipments.where(id: id).with_loot_and_character.one!
      end

      def upsert_many(raw_equipments)
        equipments.dataset.insert_conflict(
          constraint: :equipments_item_id_key,
          update: {
            updated_at: Sequel[:excluded][:updated_at]
          }
        ).multi_insert(raw_equipments)
      end
    end
  end
end

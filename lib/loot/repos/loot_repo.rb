# frozen_string_literal: true

module Loot
  module Repos
    class LootRepo < ROM::Repository[:loots]
      struct_namespace ::Loot::Entities

      include Import['container']

      commands :create,
               use: :timestamps,
               plugins_options: {
                 timestamps: {
                   timestamps: %i[created_at updated_at]
                 }
               }
      def all
        loots
          .combine(:character, :equipment, :wish)
          .sorted_by_date
          .to_a
      end

      def create_many(raw_loots)
        raw_loots.map { assign_foreign_key(_1) }

        loots.dataset.multi_insert(raw_loots)
      end

      private

      def assign_foreign_key(loot)
        equipment_dataset = equipments.dataset
        character_dataset = characters.dataset
        wish_dataset = wishes.dataset

        identifiers = loot.delete(:identifiers)

        loot[:character_id] = character_dataset.where(name: identifiers[:character_name]).select(:id)
        loot[:equipment_id] = equipment_dataset.where(item_id: identifiers[:item_id]).select(:id)
        loot[:wish_id] = wish_dataset.where(name: identifiers[:wish]).select(:id)
      end
    end
  end
end

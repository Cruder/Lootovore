# frozen_string_literal: true

module Loot
  module Repos
    class WishRepo < ROM::Repository[:wishes]
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
        equipments.to_a
      end

      def upsert_many(raw_equipments)
        wishes.dataset.insert_conflict(
          constraint: :wishes_name_key,
          update: {
            updated_at: Sequel[:excluded][:updated_at]
          }
        ).multi_insert(raw_equipments)
      end
    end
  end
end

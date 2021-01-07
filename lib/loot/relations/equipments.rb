# frozen_string_literal: true

module Loot
  module Relations
    class Equipments < ROM::Relation[:sql]
      schema(:equipments, infer: true) do
        associations do
          has_many :loots
        end
      end

      def with_loot_and_character
        combine(loots: [:wish, :character])
          .node(:loots) { |equipment_loots| equipment_loots.order { date.desc } }
      end
    end
  end
end

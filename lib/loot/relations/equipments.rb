# frozen_string_literal: true

module Loot
  module Relations
    class Equipments < ROM::Relation[:sql]
      schema(:equipments, infer: true) do
        associations do
          has_many :loots
        end
      end
    end
  end
end

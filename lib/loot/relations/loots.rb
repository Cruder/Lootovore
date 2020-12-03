# frozen_string_literal: true

module Loot
  module Relations
    class Loots < ROM::Relation[:sql]
      schema(:loots, infer: true) do
        associations do
          belongs_to :characters, as: :character
          belongs_to :equipments, as: :equipment
          belongs_to :wishes, as: :wish
        end
      end
    end
  end
end

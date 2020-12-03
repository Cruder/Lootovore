# frozen_string_literal: true

module Loot
  module Relations
    class Wishes < ROM::Relation[:sql]
      schema(:wishes, infer: true) do
        associations do
          has_many :loots
        end
      end
    end
  end
end

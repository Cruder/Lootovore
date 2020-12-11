# frozen_string_literal: true

module Loot
  module Relations
    class Characters < ROM::Relation[:sql]
      schema(:characters, infer: true) do
        associations do
          has_many :loots
        end
      end

      def with_loot_count
        join(:loots, { character_id: :id }, table_alias: :all_loots)
          .select_append { [function(:count, 'all_loots.id').as(:loot_count)] }
          .group_append(characters[:id])
      end

      def sorted_by_last_loot
        join(loots.as(:last_loot)) do |characters:, loots:|
          characters[:id].is(last_loot[:character_id])
        end.left_join(loots.as(:loot_filter)) do |characters:, loots:|
          characters[:id].is(loot_filter[:character_id]) & (last_loot[:date] < loot_filter[:date])
        end.where { Sequel::SQL::ComplexExpression.new(:IS, loot_filter[:id], nil) }
          .select_append { `"last_loot"."date"`.as(:last_loot_date) }
          .order { `"last_loot"."date"`.desc }
          .group_append { `"last_loot"."date"` }
      end

      def with_loot_and_equipment
        combine(loots: [:wish, :equipment])
          .node(:loots) { |char_loots| char_loots.order { date.desc } }
      end
    end
  end
end

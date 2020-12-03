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

# query = characters.join(loots.as(:all_loots)) do |characters:, loots:|
#   characters[:id].is(all_loots[:character_id])
# end.left_join(loots.as(:last_loots)) do |characters:, loots:|
#   characters[:id].is(last_loots[:character_id]) & (all_loots[:date] < last_loots[:date])
# end.where { Sequel::SQL::ComplexExpression.new(:IS, last_loots[:id], nil) }.select_append { `"all_loots"."date"`.as(:last_date) }.order { `"all_loots"."date"`.desc }
#
# join(:loots, loots[:character_id].is(characters[:id]), table_alias: :all_loots)
# join(:loots, loots[:character_id].is(characters[:id]).and())
#
#
# <<-SQL
# SELECT c.*, p1.*
# FROM customer c
# JOIN purchase p1 ON (c.id = p1.customer_id)
# LEFT OUTER JOIN purchase p2 ON (c.id = p2.customer_id AND 
#     (p1.date < p2.date OR (p1.date = p2.date AND p1.id < p2.id)))
# WHERE p2.id IS NULL;
# SQL
# Sequel::SQL::ComplexExpression.new('=', last_loots[:id], nil)
#
# SELECT "characters"."id", "characters"."name", "characters"."klass", "characters"."created_at", "characters"."updated_at"
# FROM "characters"
# INNER JOIN "loots" AS "all_loots" ON ("characters"."id" = "all_loots"."character_id")
# LEFT JOIN "loots" AS "last_loots" ON (("characters"."id" = "last_loots"."character_id") AND ("all_loots"."date" < "last_loots"."date"))
# WHERE ("last_loots"."id" = NULL) ORDER BY "characters"."id"
#
# ROM::SQL::ProjectionDSL

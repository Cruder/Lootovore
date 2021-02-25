# frozen_string_literal: true

module Loot
  module Repos
    class CharacterRepo < ROM::Repository[:characters]
      struct_namespace ::Loot::Entities

      include Assistant::Import['container']

      commands :create,
               use: :timestamps,
               plugins_options: {
                 timestamps: {
                   timestamps: %i[created_at updated_at]
                 }
               }

      def all(klasses:)
        characters
          .with_loot_count
          .with_loot_and_equipment
          .sorted_by_last_loot
          .then { |query| klasses_filter(query, klasses) }
          .to_a
      end

      def by_id(id)
        characters
          .by_pk(id)
          .with_loot_and_equipment
          .one
      end

      def upsert_many(raw_characters)
        characters.dataset.insert_conflict(
          constraint: :characters_name_key,
          update: {
            klass: Sequel[:excluded][:klass],
            updated_at: Sequel[:excluded][:updated_at]
          }
        ).multi_insert(raw_characters)
      end

      private

      def klasses_filter(characters, klasses)
        if klasses.empty?
          characters
        else
          characters.where(klass: klasses)
        end
      end
    end
  end
end

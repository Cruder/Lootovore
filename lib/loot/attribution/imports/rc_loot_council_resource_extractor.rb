# frozen_string_literal: true

module Loot
  module Attribution
    module Imports
      class RCLootCouncilResourceExtractor
        DEFAULT_WISH_RANK = 6

        def initialize(current_time = Time.now)
          @characters = {}
          @equipments = {}
          @wishes = {}
          @loots = []

          @current_time = current_time
        end

        def equipments
          @equipments.values
        end

        def characters
          @characters.values
        end

        def wishes
          @wishes.values
        end

        attr_reader :loots

        def extract_character(row)
          name = character_name(row['player'])

          @characters[name] = {
            name: name,
            klass: row['class'],
            created_at: @current_time,
            updated_at: @current_time
          }
        end

        def extract_equipment(row)
          @equipments[row['itemID']] = {
            name: nil,
            image: nil,
            quality: nil,
            item_id: row['itemID'],
            created_at: @current_time,
            updated_at: @current_time
          }
        end

        def extract_wishes(row)
          @wishes[row['response']] = {
            name: row['response'],
            rank: DEFAULT_WISH_RANK,
            created_at: @current_time,
            updated_at: @current_time,
          }
        end

        def extract_loot(row)
          loot_date = "#{row['date']}:#{row['time']}"

          @loots << {
            date: DateTime.strptime(loot_date, '%d/%m/%y:%H:%M:%s'),
            nb_vote: row['votes'],
            created_at: @current_time,
            updated_at: @current_time,
            identifiers: loot_identifier(row),
            note: row['note']
          }
        end

        private

        def character_name(raw_name)
          raw_name.split('-').first
        end

        def loot_identifier(row)
          {
            character_name: character_name(row['player']),
            item_id: row['itemID'],
            wish: row['response']
          }
        end
      end
    end
  end
end

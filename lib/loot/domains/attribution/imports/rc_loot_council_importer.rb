# frozen_string_literal: true

module Loot
  module Attribution
    module Imports
      class RcLootCouncilImporter
        include Import['repos.loot_repo']
        include Import['repos.character_repo']
        include Import['repos.wish_repo']
        include Import['repos.equipment_repo']

        # Data format
        # {
        #     player: String, # Kaiiur
        #     date: String, # 26/8/20
        #     time: String, # 23:23:32
        #     itemID: Integer, # 21664
        #     itemString: String, # item:21664::::::::60
        #     response: String, # +1 need
        #     votes: Integer, # 2
        #     class: String, # PALADIN
        #     instance: String, # Temple d'Ahn'Qiraj-40 joueurs
        #     boss: String, # Fankriss l'Inflexible
        #     gear1: String,
        #     gear2: String,
        #     responseID: String, # 1
        #     isAwardedReason: String, # false
        #     rollType: String, # normal
        #     subType: String, # divers
        #     equipLoc: String, # Cou
        #     note: String,
        #     owner: String
        # }
        def from_json(data)
          extractor = RCLootCouncilResourceExtractor.new

          data.map do |row|
            extractor.extract_character(row)
            extractor.extract_equipment(row)
            extractor.extract_wishes(row)
            extractor.extract_loot(row)
          end

          character_repo.upsert_many(extractor.characters)
          equipment_repo.upsert_many(extractor.equipments)
          wish_repo.upsert_many(extractor.wishes)
          loot_repo.create_many(extractor.loots)
        end
      end
    end
  end
end

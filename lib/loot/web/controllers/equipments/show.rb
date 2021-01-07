# frozen_string_literal: true

module Loot
  module Web
    module Controllers
      module Equipments
        class Show
          include Hanami::Action
          include Import['repos.equipment_repo']

          format 'json'

          configuration do
            default_response_format :json
          end

          def call(params)
            equipment = equipment_repo.by_id(params[:id])

            character_serializer = Serializers::EquipmentSerializer.new

            self.format = :json
            self.body = character_serializer.serialize(equipment).to_json
            self.status = 200
          end
        end
      end
    end
  end
end

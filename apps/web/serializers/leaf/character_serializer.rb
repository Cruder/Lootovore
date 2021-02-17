# frozen_string_literal: true

module Web
  module Serializers
    module Leaf
      class CharacterSerializer
        def serialize_multi(characters)
          characters.map { serialize(_1) }
        end

        def serialize(character)
          {
            id: character.id,
            name: character.name,
            klass: character.klass,
            icon: character.icon
          }
        end
      end
    end
  end
end

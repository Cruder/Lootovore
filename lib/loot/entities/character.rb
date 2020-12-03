# frozen_string_literal: true

module Loot
  module Entities
    class Character < ROM::Struct
      def icon
        "https://wow.zamimg.com/images/wow/icons/medium/classicon_#{klass.downcase}.jpg"
      end
    end
  end
end

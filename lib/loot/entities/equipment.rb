# frozen_string_literal: true

module Loot
  module Entities
    class Equipment < ROM::Struct
      def wowhead_url
        "https://classic.wowhead.com/item=#{item_id}"
      end

      def icon_url
        "https://wow.zamimg.com/images/wow/icons/large/#{image}.jpg"
      end
    end
  end
end

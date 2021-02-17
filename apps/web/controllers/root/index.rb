# frozen_string_literal: true

module Web
  module Controllers
    module Root
      class Index
        include Hanami::Action
        format 'json'

        def call(_params)
          self.body = {}.to_json
          self.status = 200
        end
      end
    end
  end
end

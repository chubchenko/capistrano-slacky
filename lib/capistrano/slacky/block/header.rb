# frozen_string_literal: true

module Capistrano
  module Slacky
    module Block
      class Header
        def initialize(text)
          @text = text
        end

        def as_json
          {
            type: :header,
            text: {
              type: :plain_text,
              text: @text,
              emoji: true
            }
          }
        end
      end
    end
  end
end

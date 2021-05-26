# frozen_string_literal: true

module Capistrano
  module Slacky
    module Block
      class Root
        def initialize(*blocks)
          @blocks = blocks.flatten
        end

        def to_json
          {
            blocks: @blocks.map(&:to_json)
          }
        end
      end
    end
  end
end

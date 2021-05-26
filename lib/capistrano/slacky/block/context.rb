# frozen_string_literal: true

module Capistrano
  module Slacky
    module Block
      class Context
        def initialize(*elements)
          @elements = elements.map do |element|
            Element.new(element)
          end
        end

        def to_json
          {
            type: :context,
            elements: @elements.map(&:to_json)
          }
        end

        class Element
          def initialize(text)
            @text = text
          end

          def to_json
            {
              type: :mrkdwn,
              text: @text
            }
          end
        end
      end
    end
  end
end

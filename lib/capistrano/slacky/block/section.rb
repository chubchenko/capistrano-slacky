# frozen_string_literal: true

module Capistrano
  module Slacky
    module Block
      class Section
        def initialize(*fields)
          @fields = fields.map do |field|
            Field.new(field)
          end
        end

        def to_json
          {
            type: :section,
            fields: @fields.map(&:to_json)
          }
        end

        class Field
          def initialize(text)
            @text = text
          end

          def to_json
            {
              type: :mrkdwn, text: @text
            }
          end
        end
      end
    end
  end
end

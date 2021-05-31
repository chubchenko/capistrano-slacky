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

        def as_json
          {
            type: :section,
            fields: @fields.map(&:as_json)
          }
        end

        class Field
          def initialize(text)
            @text = text
          end

          def as_json
            {
              type: :mrkdwn, text: @text
            }
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Capistrano
  module Slacky
    module Messaging
      class Null < Base
        def payload_for_updated
          nil
        end

        def payload_for_reverted
          nil
        end

        def payload_for_failed
          nil
        end
      end
    end
  end
end

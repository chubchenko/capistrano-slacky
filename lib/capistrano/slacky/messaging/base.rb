# frozen_string_literal: true

module Capistrano
  module Slacky
    module Messaging
      UnpermittedAction = Class.new(StandardError) do
        def initialize(action:)
          super("Unpermitted action: #{action}.")
        end
      end

      class Base
        PERMITTED_ACTIONS = [
          :updated,
          :reverted,
          :failed
        ].freeze

        private_constant :PERMITTED_ACTIONS

        def initialize(env:)
          @env = env
        end

        def payload_for(action:)
          raise UnpermittedAction.new(action: action) unless PERMITTED_ACTIONS.include?(action)

          public_send("payload_for_#{action}")
        end

        private

        attr_reader :env
      end
    end
  end
end

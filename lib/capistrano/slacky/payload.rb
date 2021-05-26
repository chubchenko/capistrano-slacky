# frozen_string_literal: true

require_relative "messaging"

module Capistrano
  module Slacky
    class Payload
      def initialize(env:, action:)
        @env = env
        @action = action
        @messaging = ::Capistrano::Slacky::Messaging.for(env: env)
      end

      def to_json
        {
          username: ::Capistrano::Slacky.username,
          icon_emoji: ::Capistrano::Slacky.icon_emoji,
          channel: ::Capistrano::Slacky.channel
        }.merge(
          @messaging.payload_for(action: @action)
        ).to_json
      end
    end
  end
end

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

      def empty?
        payload_for_action.nil?
      end

      def to_json
        {
          username: ::Capistrano::Slacky.username,
          icon_emoji: ::Capistrano::Slacky.icon_emoji,
          channel: ::Capistrano::Slacky.channel
        }.merge(
          payload_for_action
        ).to_json
      end

      private

      def payload_for_action
        @payload_for_action ||= @messaging.payload_for(action: @action)
      end
    end
  end
end

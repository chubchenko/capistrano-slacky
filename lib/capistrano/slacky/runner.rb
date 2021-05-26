# frozen_string_literal: true

require_relative "payload"
require_relative "fanout"

module Capistrano
  module Slacky
    class Runner
      def self.call(env:, action:)
        payload = ::Capistrano::Slacky::Payload.new(
          env: env, action: action
        )

        ::Capistrano::Slacky::Fanout.call(payload: payload)
      end
    end
  end
end

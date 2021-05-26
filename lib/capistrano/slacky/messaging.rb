# frozen_string_literal: true

require_relative "messaging/base"
require_relative "messaging/default"
require_relative "messaging/null"

module Capistrano
  module Slacky
    module Messaging
      def self.for(env:)
        klass =
          if ::Capistrano::Slacky.slacky?
            (::Capistrano::Slacky.klass || Default)
          else
            Null
          end

        klass.new(env: env)
      end
    end
  end
end

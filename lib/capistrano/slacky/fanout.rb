# frozen_string_literal: true

module Capistrano
  module Slacky
    module Hook
      require "uri"

      DEFAULT_HOOK_FILE = "config/slacky.yml"

      module_function

      def uri
        output = nil

        ::Capistrano::Slacky.on(within: :shared) do
          output = ::SSHKit::Backend.current.capture(:cat, DEFAULT_HOOK_FILE)
        end

        URI(output)
      end
    end

    private_constant :Hook

    class Fanout
      require "net/http"

      def self.call(payload:, hook: Hook)
        ::Net::HTTP.post_form(
          hook.uri, payload: payload.to_json
        )
      end
    end
  end
end

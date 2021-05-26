# frozen_string_literal: true

module Capistrano
  module Slacky
    module Hook
      require "uri"

      DEFAULT_HOOK_FILE = "config/slacky.yml"

      module_function

      def uri(role: Hook.role)
        output = nil

        on(role) do
          output = capture(:cat, File.join(shared_path, DEFAULT_HOOK_FILE))
        end

        URI(output)
      end

      def role
        ::Capistrano::Configuration.env.primary(:app)
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

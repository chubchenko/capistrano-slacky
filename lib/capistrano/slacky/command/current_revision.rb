# frozen_string_literal: true

module Capistrano
  module Slacky
    module Command
      class CurrentRevision
        REVISION_FILE = "REVISION"

        private_constant :REVISION_FILE

        def self.call
          output = nil

          ::Capistrano::Slacky.on(within: :release) do
            output = ::SSHKit::Backend.current.capture(:cat, REVISION_FILE)
          end

          output
        end
      end
    end
  end
end

# frozen_string_literal: true

module Capistrano
  module Slacky
    module Command
      class Duration
        def self.call(pid: $PID)
          ::IO.popen(["ps", "-p", pid.to_s, "-o", "etime="]).readline.strip
        end
      end
    end
  end
end

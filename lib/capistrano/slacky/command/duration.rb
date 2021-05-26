# frozen_string_literal: true

module Capistrano
  module Slacky
    module Command
      class Duration
        def self.call(pid: $PID)
          `ps -p #{pid} -o etime=`.strip
        end
      end
    end
  end
end

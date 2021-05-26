# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class Body < ::Capistrano::Slacky::Block::Section
        def initialize(env:)
          @env = env

          super(
            t("slacky.stage"), "`#{stage}`",
            t("slacky.branch"), "`#{branch}`",
            t("slacky.duration"), "`#{duration}`",
          )
        end

        private

        attr_reader :env

        def stage
          @stage ||= env.fetch(:stage)
        end

        def branch
          @branch ||= env.fetch(:branch)
        end

        def duration
          @duration ||= ::Capistrano::Slacky::Command::Duration.call
        end
      end
    end
  end
end

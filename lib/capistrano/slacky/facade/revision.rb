# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class Revision < ::Capistrano::Slacky::Block::Context
        def initialize(env:)
          @env = env

          super(
            I18n.t("slacky.revision", scope: "capistrano",
                                      repository_url: ::Capistrano::Slacky.repo.url,
                                      current: current,
                                      previous: previous)
          )
        end

        private

        attr_reader :env

        def current
          env.fetch(:current_revision)[0, 7]
        end

        def previous
          env.fetch(:previous_revision)[0, 7]
        end
      end
    end
  end
end

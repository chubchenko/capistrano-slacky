# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class Changelog
        def self.for(env:)
          new(
            previous: env.fetch(:previous_revision),
            current: env.fetch(:current_revision)
          ).call
        end

        attr_accessor :difference

        def initialize(previous:, current:)
          ref = self

          on(::Capistrano::Configuration.env.primary(:app)) do
            within repo_path do
              ref.difference = ::Capistrano::Slacky::Command::Diff.call(
                previous: previous,
                current: current
              )
            end
          end
        end

        def call
          if difference.empty?
            return ::Capistrano::Slacky::Block::Context.new(
              ::I18n.t("slacky.nothing_has_changed_since_the_previous_release", scope: "capistrano")
            )
          end

          difference.map do |message|
            ::Capistrano::Slacky::Block::Context.new(
              *message.to_a
            )
          end
        end
      end
    end
  end
end

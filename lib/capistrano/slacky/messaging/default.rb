# frozen_string_literal: true

module Capistrano
  module Slacky
    module Messaging
      class Default < Base
        def payload_for_updated
          ::Capistrano::Slacky::Facade::Root.new(
            ::Capistrano::Slacky::Facade::Header.new(:deployed_successfully),
            ::Capistrano::Slacky::Facade::Body.new(env: env),
            ::Capistrano::Slacky::Facade::Revision.new(env: env),
            ::Capistrano::Slacky::Facade::Changelog.for(env: env),
            ::Capistrano::Slacky::Facade::DeployedBy.new(env: env)
          ).to_json
        end

        def payload_for_reverted
          ::Capistrano::Slacky::Facade::Root.new(
            ::Capistrano::Slacky::Facade::Header.new(:reverted_successfully),
            ::Capistrano::Slacky::Facade::Body.new(env: env),
            ::Capistrano::Slacky::Facade::Revision.new(env: env),
            ::Capistrano::Slacky::Facade::DeployedBy.new(env: env)
          ).to_json
        end

        def payload_for_failed
          ::Capistrano::Slacky::Facade::Root.new(
            ::Capistrano::Slacky::Facade::Header.new(deploying? ? :deployment_failed : :rollback_failed),
            ::Capistrano::Slacky::Facade::Body.new(env: env),
            ::Capistrano::Slacky::Facade::Exception.new,
            ::Capistrano::Slacky::Facade::DeployedBy.new(env: env)
          ).to_json
        end
      end
    end
  end
end

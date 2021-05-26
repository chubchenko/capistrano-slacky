# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class DeployedBy < ::Capistrano::Slacky::Block::Context
        def initialize(env:)
          super(
            t("slacky.deployed_by", deployer: env.fetch(:local_user))
          )
        end
      end
    end
  end
end

# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class DeployedBy < ::Capistrano::Slacky::Block::Context
        def initialize(env:)
          super(
            ::I18n.t("slacky.deployed_by", scope: "capistrano", deployer: env.fetch(:local_user))
          )
        end
      end
    end
  end
end

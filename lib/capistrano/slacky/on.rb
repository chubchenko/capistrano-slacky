# frozen_string_literal: true

module Capistrano
  module Slacky
    module On
      class Path
        extend ::Capistrano::DSL
      end

      PATH_MAP = {
        repository: -> { Path.repo_path },
        shared: -> { Path.shared_path },
        release: -> { Path.release_path }
      }.freeze

      private_constant :PATH_MAP

      module_function

      def on(within:, &block)
        role = ::Capistrano::Configuration.env.primary(:app) || ::Capistrano::Configuration.env.roles(:all).first

        ::Capistrano::DSL.on(role) do
          ::SSHKit::Backend.current.within(PATH_MAP.fetch(within).call, &block)
        end
      end
    end
  end
end

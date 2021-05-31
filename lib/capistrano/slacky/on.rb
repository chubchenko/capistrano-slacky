# frozen_string_literal: true

module Capistrano
  module Slacky
    module On
      class Path
        extend ::Capistrano::DSL
      end

      PATH_MAP = {
        repository: -> { Path.repo_path },
        shared: -> { Path.shared_path }
      }.freeze

      private_constant :PATH_MAP

      module_function

      def on(within:, &block)
        ::Capistrano::DSL.on(::Capistrano::Configuration.env.primary(:app)) do
          ::SSHKit::Backend.current.within(PATH_MAP.fetch(within).call, &block)
        end
      end
    end
  end
end

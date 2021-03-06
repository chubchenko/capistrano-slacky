# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class Exception < ::Capistrano::Slacky::Block::Context
        DefaultException = ::Class.new(::StandardError) do
          def initialize
            super(::I18n.t("slacky.something_went_wrong", scope: "capistrano"))
          end
        end

        private_constant :DefaultException

        def initialize(exception: $ERROR_INFO)
          super(
            (exception || DefaultException.new).message
          )
        end
      end
    end
  end
end

# frozen_string_literal: true

load File.expand_path("../../tasks/slacky.rake", __FILE__)

require_relative "slacky/version"
require_relative "slacky/configuration"
require_relative "slacky/i18n"
require_relative "slacky/runner"
require_relative "slacky/block"
require_relative "slacky/facade"
require_relative "slacky/command"

module Capistrano
  module Slacky
    module_function

    # Delegate any missing method call to the configuration
    def method_missing(method_name, *arguments, &block)
      return super unless configuration.respond_to?(method_name)

      configuration.public_send(method_name, *arguments, &block)
    end

    # Replace the Object.respond_to?() method
    def respond_to_missing?(method_name, include_private = false)
      configuration.respond_to?(method_name) || super
    end

    # @return [Capistrano::Slacky::Configuration]
    def configuration
      @configuration ||= ::Capistrano::Slacky::Configuration.new
    end

    private_class_method :configuration
  end
end

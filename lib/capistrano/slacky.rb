# frozen_string_literal: true

load File.expand_path("../../tasks/slacky.rake", __FILE__)

require "forwardable"

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

    extend ::SingleForwardable

    def_delegators :configuration, :username, :icon_emoji, :channel, :klass, :slacky?, :repo

    # @return [Capistrano::Slacky::Configuration]
    def configuration
      @configuration ||= ::Capistrano::Slacky::Configuration.new
    end

    private_class_method :configuration
  end
end

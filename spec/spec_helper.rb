# frozen_string_literal: true

require "simplecov"
require "bundler/setup"
require "support/config/capistrano"
require "support/config/rake"
require "capistrano/slacky"

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end

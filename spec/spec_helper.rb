# frozen_string_literal: true

require "simplecov"
require "bundler/setup"
require "capistrano/slacky"

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end

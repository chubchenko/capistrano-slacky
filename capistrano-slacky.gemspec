# frozen_string_literal: true

require_relative "lib/capistrano/slacky/version"

Gem::Specification.new do |spec|
  spec.name = "capistrano-slacky"
  spec.version = Capistrano::Slacky::VERSION
  spec.summary = "Send Capistrano deployment status to Slack"
  spec.description = "Send Capistrano deployment status to Slack via the incoming webhooks integration"
  spec.author = "Artem Chubchenko"

  spec.license = "MIT"
  spec.email = "artem.chubchenko@gmail.com"
  spec.homepage = "https://github.com/chubchenko/capistrano-slacky"
  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/chubchenko/capistrano-slacky/issues",
    "changelog_uri" => "https://github.com/chubchenko/capistrano-slacky/blob/master/CHANGELOG.md",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/chubchenko/capistrano-slacky",
    "github_repo" => "ssh://github.com/chubchenko/capistrano-slacky"
  }

  spec.files = Dir["{lib}/**/*", "*.md"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.add_dependency "capistrano", "~> 3.0", ">= 3.0.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "webmock", "~> 3.12"
end

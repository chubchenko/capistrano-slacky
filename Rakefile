# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new

  RuboCop::RakeTask.new("rubocop:md") do |task|
    task.options << %w[-c .rubocop-md.yml]
  end
rescue LoadError
  desc "Lint Ruby files with RuboCop"
  task(:rubocop)

  desc "Lint Markdown files with RuboCop"
  task("rubocop:md")
end

task default: %w[rubocop rubocop:md spec]

# frozen_string_literal: true

namespace :load do
  desc "Load default configuration for slacky"
  task :defaults do
    append :linked_files, "config/slacky.yml"
  end
end

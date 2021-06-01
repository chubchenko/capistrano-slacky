# frozen_string_literal: true

namespace :load do
  task :defaults do
    append :linked_files, "config/slacky.yml"
  end
end

# frozen_string_literal: true

namespace :deploy do
  desc "Dummy for a successful deployment"
  task :finishing

  desc "Dummy for successful rollback"
  task :finishing_rollback

  desc "Dummy for failure deployment or rollback"
  task :failed
end

# frozen_string_literal: true

namespace :slacky do
  desc "Slacky after a successful deployment"
  task :updated do
    Capistrano::Slacky::Runner.call(
      env: self, action: :updated
    )
  end

  desc "Slacky after successful rollback"
  task :reverted do
    Capistrano::Slacky::Runner.call(
      env: self, action: :reverted
    )
  end

  desc "Slacky after failure deployment or rollback"
  task :failed do
    Capistrano::Slacky::Runner.call(
      env: self, action: :failed
    )
  end

  # task :ping do
  #   [:updated, :reverted, :failed].each do |action|
  #     Capistrano::Slacky::Runner.call(
  #       env: self, action: action
  #     )
  #   end
  # end
end

before :'deploy:finishing', :'slacky:updated'
before :'deploy:finishing_rollback', :'slacky:reverted'
before :'deploy:failed', :'slacky:failed'

namespace :load do
  task :defaults do
    append :linked_files, "config/slacky.yml"
  end
end

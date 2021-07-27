# frozen_string_literal: true

namespace :slacky do
  desc "Slacky after a successful deployment"
  task :updated do
    Capistrano::Slacky::Runner.call(action: :updated)
  end

  desc "Slacky after successful rollback"
  task reverted: [:ensure_current_revision] do
    Capistrano::Slacky::Runner.call(action: :reverted)
  end

  desc "Slacky after failure deployment or rollback"
  task :failed do
    Capistrano::Slacky::Runner.call(action: :failed)
  end

  desc "Slacky all slackable task (updated, reverted, failed)"
  task :ping do
    ask(:previous_revision) unless env.any?(:previous_revision)
    ask(:current_revision) unless env.any?(:current_revision)

    [:updated, :reverted, :failed].each do |action|
      Capistrano::Slacky::Runner.call(action: action)
    end
  end

  desc "Ensure that the current revision is set"
  task :ensure_current_revision do
    set_if_empty(:current_revision) { Capistrano::Slacky::Command::CurrentRevision.call }
  end
end

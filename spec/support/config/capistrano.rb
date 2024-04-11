# frozen_string_literal: true

require "capistrano/all"

load File.expand_path("capistrano.rake", __dir__)

# Set URL to the repository.
Capistrano::Configuration.env.set(
  :repo_url, "git@github.com:chubchenko/capistrano-slacky.git"
)

# Set the stage name.
Capistrano::Configuration.env.set(
  :stage, "production"
)

# Set the branch name to be deployed from SCM.
Capistrano::Configuration.env.set(
  :branch, "main"
)

# Set the user name.
Capistrano::Configuration.env.set(
  :local_user, "chubchenko"
)

# Set the previous and current revisions.
Capistrano::Configuration.env.set(
  :previous_revision, "2eab27b"
)
Capistrano::Configuration.env.set(
  :current_revision, "02c4c96"
)

# Set the deployment directory.
Capistrano::Configuration.env.set(
  :deploy_to,
  "var/www/slacky"
)

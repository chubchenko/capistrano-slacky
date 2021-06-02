<div align="center">
  <img align="center"
       height="100"
       title="dn-ruby logo"
       src="./assets/images/logo.svg">
</div>

[![gem version][9]][10]
[![build][1]][2]
[![downloads][11]][12]

# capistrano-slacky

Send `Capistrano` deployment status to `Slack` via the Incoming Webhooks integration.

- Messages are built on the basis of the [Block Kit][13]. See [Demo](#demo) section.
- Fires after every successful/failed deployment or rollback
- Use _Incoming Webhook URL_ from the remote server.
- Send commit log between 2 deployments.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Demo](#demo)

## Requirements

- Ruby >= 2.5
- Capistrano ~> 3.0
- Slack

## Installation

Add the following line to your `Gemfile`:

```ruby
gem "capistrano-slacky", "~> 0.1", require: false
```

And then execute:

```bash
bundle install
```

## Configuration

Out of the box, the gem has a default configuration:

```ruby
set :slacky, username: "ChatOps", # Set your bot's user name.
             icon_emoji: ":robot_face:", # Emoji to use as the icon for this message.
             channel: "#deployment", # The name of the channel to send a message to.
             klass: Capistrano::Slacky::Messaging::Default # The class that responsible for creating a message.
```

So you can easily tweak your deployment messages and all other configuration to what you want.

## Usage

Require the library in your application's Capfile

```ruby
require "capistrano/slacky"
```

- Add an [Incoming Webhooks][4] to your Slack.
- The received _Incoming Webhook URL_ must be uploaded to the remote server. It should be stored in a `shared` directory under the following path `config/slacky.yml`.
- Run `cap production slacky:ping` command to test your integration.

That's all, deploy your application as usual and you will see a deployment notification in your Slack channel.

In case if you want to disable deployment notifications for a specific stage just set `slacky` to `false`.

```ruby
set :slacky, false
```

## Demo

![Deployed successfully][5]

![Reverted successfully][6]

## Supported Ruby Versions

This library aims to support and is [tested against][2] the following Ruby implementations:

- Ruby 2.5
- Ruby 2.6
- Ruby 2.7
- Ruby 3.0

If something doesn't work on one of these Ruby versions, it's a bug.

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][4]. Violations of this scheme should be reported as bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that version should be immediately yanked, and/or a new version should be immediately released that restores compatibility. Breaking changes to the public API will only be introduced with new major versions. As a result of this policy, you can (and should) specify a dependency on this gem using the [Pessimistic Version Constraint][5] with two digits of precision. For example:

```ruby
gem "capistrano-slacky", "~> 0.1"
```

## License

[MIT][3]

[1]: https://github.com/chubchenko/capistrano-slacky/actions/workflows/build.yml/badge.svg
[2]: https://github.com/chubchenko/capistrano-slacky/actions/workflows/build.yml
[3]: https://choosealicense.com/licenses/mit
[4]: https://api.slack.com/messaging/webhooks
[5]: ./assets/images/deployed_successfully.jpg
[6]: ./assets/images/deployment_failed.jpg
[7]: ./assets/images/reverted_successfully.jpg
[8]: ./assets/images/rollback_failed.jpg
[9]: https://badge.fury.io/rb/capistrano-slacky.svg
[10]: https://badge.fury.io/rb/capistrano-slacky
[11]: https://img.shields.io/gem/dt/capistrano-slacky
[12]: https://rubygems.org/gems/capistrano-slacky
[13]: https://api.slack.com/block-kit

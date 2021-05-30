# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- Use `I18n.t` instead of `t`. ([@chubchenko][])
- Use `forwardable` instead of `method_missing` + `respond_to_missing?`. ([@chubchenko][])

### Fixed
- Use `@env` instance variable instead of missing getter `env`. ([@chubchenko][])
- Update your SSH regex to match the repository with a dash in the name. ([@chubchenko][])

### Security
- Fix possible command injection during the duration retrieval. ([@chubchenko][])

## [0.1.1] - 2021-05-27
### Fixed
- Fix a bug related to using a `Null` messaging. ([@chubchenko][])

## [0.1.0] - 2021-05-26
### Added
- Initial version. ([@chubchenko][])

[@chubchenko]: https://github.com/chubchenko
[Unreleased]: https://github.com/chubchenko/capistrano-slacky/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/chubchenko/capistrano-slacky/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/chubchenko/capistrano-slacky/releases/tag/v0.1.0

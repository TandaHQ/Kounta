# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added

### Changed
- Switched from OJ gem to Ruby's native JSON library for better performance

### Fixed

### Removed
- Removed OJ gem dependency


## [0.3.0] - 2018-11-28
### Changed
- Allow OJ gem version 3

### Removed
- Removed support for Ruby 2.2 (should still currently work, but not supported moving forward)

## [0.2.4] - 2018-06-07
### Added
- Authentication flow - https://github.com/TandaHQ/Kounta/pull/1
- Ability to delete resources
- Break, Shift, Staff, Webhook resources

### Fixed
- General cleanup of repo, now complying with Rubocop file
- Issues with pagination requesting the first page twice
- Brought tests up to date

### Removed
- Drop support of Ruby 2.0 and 2.1 (should still currently work, but not supported moving forward)
- `Kounta.root` method

[Unreleased]: https://github.com/TandaHQ/Kounta/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/TandaHQ/Kounta/compare/v0.2.4...v0.3.0
[0.2.4]: https://github.com/TandaHQ/Kounta/compare/v0.1.7...v0.2.4

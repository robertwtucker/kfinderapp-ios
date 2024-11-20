# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

- Added `TelemetryDeck` for analytics ([#53](https://github.com/robertwtucker/kfinderapp-ios/issues/53))

## [v1.0.2] - 2024-11-17

### Fixed

- Added `nonstrict-hq/CloudStorage` to sync user settings in iCloud ([#51](https://github.com/robertwtucker/kfinderapp-ios/pull/51))

## [v1.0.1] - 2024-11-17

### Changed

- Updated in-app links to use legal docs on website ([#47](https://github.com/robertwtucker/kfinderapp-ios/pull/47))

### Fixed

- Improved reminder handling and display ([#44](https://github.com/robertwtucker/kfinderapp-ios/pull/44))
- Adjusted view padding when recent foods list is empty ([#43](https://github.com/robertwtucker/kfinderapp-ios/pull/43))

## [v1.0.0] - 2024-11-15

Initial beta release to TestFlight

### Added

- Use fastlane to support beta and release distribution ([#39](https://github.com/robertwtucker/kfinderapp-ios/pull/39))

## [v0.5.0] - 2024-11-13

Feature-complete MVP to begin testing for release in the app store.

### Added

- Added CI and code scanning scripts ([#28](https://github.com/robertwtucker/kfinderapp-ios/pull/28))
- Feature to create and track PT/INR testing reminders ([#32](https://github.com/robertwtucker/kfinderapp-ios/pull/32),
  [#25](https://github.com/robertwtucker/kfinderapp-ios/pull/25))
- Support for listing configurable number of most-recenly viewed foods ([#35](https://github.com/robertwtucker/kfinderapp-ios/pull/35),
  [#26](https://github.com/robertwtucker/kfinderapp-ios/pull/26),
  [#22](https://github.com/robertwtucker/kfinderapp-ios/pull/22))
- Synchronized storage with SwiftData and CloudKit ([#17](https://github.com/robertwtucker/kfinderapp-ios/pull/17))

### Changed

- Refactored app directory structure, moved shared components to internal
  packages
- Updated to Xcode 16 and Swift 6 ([#15](https://github.com/robertwtucker/kfinderapp-ios/pull/15))

## [v0.4.0] - 2023-11-09

### Changed

- Rewrote using SwiftUI and Swift 5

## [v0.3.0] - 2017-02-15

Began migration to a tab-based interface -- currently Home, Search and Settings.

### Added

- Home Tab placeholder (the dashboard/info is still TBD)
- Settings Tab with acknowledgements page and application version display (the
  account section is currently non-functional)
- Switch toggles the display of the serving weight between metric and imperial
  units (Settings Tab)

### Changed

- Main UI now tab-based to facilitate adding functionality incrementally
- Search functionality moved to Search Tab
- Switched license to Apache 2.0
- Updated RxSwift to v3.2.0 and Realm to v2.4.2

## [v0.2.1] - 2016-12-30

Testing hotfix workflow with some items that were missed before shipping 0.2.0.

### Fixed

- Acknowledgements for new libraries omitted from the NOTICE file
- Reference link in the Change Log for the current release is broken

## [v0.2.0] - 2016-12-30

Reimplemented prototype using Reactive Programming principles and an architecture
based on the Model-View-ViewModel pattern

### Added

- Framework dependencies: [RxSwift](https://github.com/ReactiveX/RxSwift)/RxCocoa,
  [RxRealm](https://github.com/RxSwiftCommunity/RxRealm)
- Change log

### Changed

- Updated RxSwift and RxCocoa from v3.0.1 to v3.1.0

## v0.1.0 - 2016-12-26

Initial prototype with basic search and display

### Added

- [CSV.swift](https://github.com/yaslab/CSV.swift) library for parsing the
  USDA's food data on first run
- Continuous integration (CI) build support with [Travis CI](https://travis-ci.org/robertwtucker/kfinderapp-ios)

### Changed

- Switched from [Carthage](https://github.com/Carthage/Carthage) to
  [CocoaPods](https://cocoapods.org/about) for dependency management
- Replaced CoreData with [Realm](https://realm.io/)

[Unreleased]: https://github.com/robertwtucker/kfinderapp-ios/compare/v1.0.2...HEAD
[v1.0.2]: https://github.com/robertwtucker/kfinderapp-ios/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/robertwtucker/kfinderapp-ios/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/robertwtucker/kfinderapp-ios/compare/v0.5.0...v1.0.0
[v0.5.0]: https://github.com/robertwtucker/kfinderapp-ios/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/robertwtucker/kfinderapp-ios/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/robertwtucker/kfinderapp-ios/compare/v0.2.1...v0.3.0
[v0.2.1]: https://github.com/robertwtucker/kfinderapp-ios/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/robertwtucker/kfinderapp-ios/compare/v0.1.0...v0.2.0

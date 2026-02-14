# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KFinder is a SwiftUI iOS app for anti-coagulation therapy management — helping users track Vitamin K intake and PT/INR blood test reminders. It uses the USDA FoodData Central API for food/nutrient data.

## Build & Test Commands

```bash
# Build (requires macOS with Xcode 16+)
xcodebuild clean build -scheme KFinder -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' | xcpretty

# Run all tests (package tests via SPM)
xcodebuild test -scheme KFinder -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' | xcpretty

# Lint
swiftlint

# Fastlane lanes
bundle exec fastlane screenshots
bundle exec fastlane build_release
bundle exec fastlane beta
```

## Architecture

**Modular SPM packages** under `Packages/`:
- **Models** — Data models: `FoodItem` (SwiftData `@Model`), `Reminder`, FoodData Central API response types
- **Services** — `FoodDataCentralService` (REST client), `ReminderManager`/`ReminderStore` (EventKit), `UserPreferences` (backed by SwiftData `UserSettings` model). Depends on Models
- **DesignSystem** — Reusable UI components, color tokens (Tailwind-inspired), view modifiers, styles

Each package has its own test target (`ModelsTests`, `ServicesTests`, `DesignSystemTests`).

**App target** (`KFinder/`) uses feature-based folder structure:
- `Application/Main/` — App entry (`KFinderApp`), `ContentView` (environment/SwiftData setup), `AppTabView`
- `Application/Tabs/Home/` — Test reminder management, recent foods
- `Application/Tabs/Foods/` — Food search, detail views, nutrient lists
- `Application/Settings/` — User preferences, Vitamin K target, about

**State management:** `@Observable` macro with `@Environment` injection (iOS 17+ patterns). No MVVM — views use observable services and helper classes directly.

**Persistence:** SwiftData for food items and user settings (CloudKit-synced), EventKit for reminders.

## Key Conventions

- **iOS 17.0** deployment target; SPM packages use **Swift Tools 6.0** with Swift 6 language mode in Services
- All source files require SPDX license headers: `SPDX-FileCopyrightText: (c) 2024 Robert Tucker` / `SPDX-License-Identifier: MIT`
- SwiftLint enforced: minimum 3-char identifiers (exceptions: `id`, `g`, `kJ`, `kcal`, `mg`, `ug`, `URL`)
- PR titles must follow semantic commit convention (enforced by CI)
- API keys (`FDC_API_KEY`, `TELEMETRY_DECK_APP_ID`) are in `Secrets.xcconfig` (git-ignored)

## Dependencies

- **TelemetryDeck** (v2.9.4) — Privacy-first analytics
- **fastlane** — Build automation (Ruby gem)

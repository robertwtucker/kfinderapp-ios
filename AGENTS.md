# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Project Overview

KFinder is a SwiftUI iOS app for anti-coagulation therapy management — helping users track Vitamin K intake and PT/INR blood test reminders. It uses the USDA FoodData Central API for food/nutrient data.

## Build, Test, and Apple Platform Development

**Prefer XcodeBuildMCP** for all iOS/macOS/watchOS/tvOS/visionOS work (build, test, run, debug, log, UI automation, simulator/device management).

Use the `xcodebuildmcp` CLI **or** the connected MCP tools (discovered via `search_tool`, invoked via `use_tool` with fully-qualified names like `xcodebuildmcp__build_run_sim`).

### Step 1: Verify CLI / MCP Availability

```bash
xcodebuildmcp --help
xcodebuildmcp tools
```

If the CLI is missing:

```bash
brew tap getsentry/xcodebuildmcp
brew install xcodebuildmcp
# or
npm install -g xcodebuildmcp@latest
```

### Step 2: Help-First Discovery (Always)

Do **not** hard-code command lists. Discover workflows and arguments dynamically:

```bash
xcodebuildmcp --help
xcodebuildmcp tools
xcodebuildmcp <workflow> --help
xcodebuildmcp <workflow> <tool> --help
```

Example workflows: `simulator`, `device`, `debugging`, `ui-automation`, `simulator-management`, `project-discovery`, etc.

### Step 3: Session Defaults (Mandatory Before Build/Run/Test)

**Before your first build, run, or test call in a session, you MUST call `session_show_defaults` (MCP: `xcodebuildmcp__session_show_defaults`) to verify the active project/workspace, scheme, and simulator/device.**

Do not assume defaults are configured.

For this project, typical defaults (set via `xcodebuildmcp__session_set_defaults` with `persist: true` when appropriate):

- `projectPath`: `/Users/robert/projects/kfinderapp-ios/KFinder.xcodeproj`
- `scheme`: `KFinder`
- `simulatorName`: `iPhone Air`
- `simulatorPlatform`: `iOS Simulator`

Once defaults are confirmed correct, prefer the combined `build_run_sim` (MCP: `xcodebuildmcp__build_run_sim`) with empty arguments for simulator run intent.

Do **not** chain separate `build` then `build-and-run` unless explicitly requested.

### Legacy Raw Commands (Avoid When Possible)

These were the pre-XcodeBuildMCP commands:

<!-- markdownlint-disable MD013 -->

```bash
# Build (requires macOS with Xcode 16+)
xcodebuild clean build -scheme KFinder -destination 'platform=iOS Simulator,name=iPhone Air,OS=26.2' | xcpretty

# Run all tests (package tests via SPM)
xcodebuild test -scheme KFinder -destination 'platform=iOS Simulator,name=iPhone Air,OS=26.2' | xcpretty
```

<!-- markdownlint-enable MD013 -->

Lint and Fastlane remain unchanged:

```bash
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
- All source files require SPDX license headers: `SPDX-FileCopyrightText: (c) 2026 Robert Tucker` / `SPDX-License-Identifier: MIT`
- SwiftLint enforced: minimum 3-char identifiers (exceptions: `id`, `g`, `kJ`, `kcal`, `mg`, `ug`, `URL`)
- PR titles must follow semantic commit convention (enforced by CI)
- API keys (`FDC_API_KEY`, `TELEMETRY_DECK_APP_ID`) are in `Secrets.xcconfig` (git-ignored)

## Dependencies

- **TelemetryDeck** (v2.12.0) — Privacy-first analytics
- **fastlane** — Build automation (Ruby gem)

## XcodeBuildMCP Integration

This repository uses XcodeBuildMCP (both CLI and MCP server) for all Apple platform tasks.

- The official skill lives at `/Users/robert/.agents/skills/xcodebuildmcp-cli/SKILL.md`
- The MCP server is configured via `.mcp.json` (and optionally `.xcodebuildmcp/config.yaml` for project defaults)
- Always follow the skill's "help-first" and "check session defaults" rules
- Prefer the MCP tools (`xcodebuildmcp__*`) when available in the agent environment, falling back to the `xcodebuildmcp` CLI when needed


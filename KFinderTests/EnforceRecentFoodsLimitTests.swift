//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import Services
import SwiftData
import Testing

// Drives the static `UserPreferences.enforceRecentFoodsLimit(in:limit:)`
// directly so tests don't go through the singleton's configure/observer
// lifecycle (which leaks observers across tests in the same host process).
@Suite("enforceRecentFoodsLimit")
@MainActor
struct EnforceRecentFoodsLimitTests {

  private func makeContainer() throws -> ModelContainer {
    try ModelContainer(
      for: RecentFood.self,
      configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
  }

  private func insertRecent(
    _ context: ModelContext, fdcId: Int, viewedAt: Date
  ) {
    context.insert(
      RecentFood(
        fdcId: fdcId,
        name: "food-\(fdcId)",
        dataType: "Survey (FNDDS)",
        viewedAt: viewedAt))
  }

  @Test("prunes to limit when over by one")
  func prunesOverByOne() throws {
    let container = try makeContainer()
    let context = container.mainContext
    let base = Date(timeIntervalSince1970: 1_700_000_000)
    for index in 0..<6 {
      insertRecent(
        context, fdcId: 1000 + index,
        viewedAt: base.addingTimeInterval(TimeInterval(index)))
    }
    try context.save()

    UserPreferences.enforceRecentFoodsLimit(in: context, limit: 5)

    let remaining = try context.fetch(FetchDescriptor<RecentFood>())
    #expect(remaining.count == 5)
  }

  @Test("evicts oldest viewedAt first")
  func evictsOldestFirst() throws {
    let container = try makeContainer()
    let context = container.mainContext
    let base = Date(timeIntervalSince1970: 1_700_000_000)
    // fdcId chosen so insert order != viewedAt order — guards against
    // the prune accidentally relying on insertion order.
    insertRecent(context, fdcId: 5, viewedAt: base.addingTimeInterval(100))
    insertRecent(context, fdcId: 1, viewedAt: base.addingTimeInterval(10))
    insertRecent(context, fdcId: 4, viewedAt: base.addingTimeInterval(80))
    insertRecent(context, fdcId: 2, viewedAt: base.addingTimeInterval(20))
    insertRecent(context, fdcId: 3, viewedAt: base.addingTimeInterval(60))
    try context.save()

    UserPreferences.enforceRecentFoodsLimit(in: context, limit: 3)

    let survivingIds = Set(
      try context.fetch(FetchDescriptor<RecentFood>()).map(\.fdcId))
    #expect(survivingIds == [3, 4, 5])
  }

  @Test("resolves equal-viewedAt ties by fdcId")
  func tieResolution() throws {
    let container = try makeContainer()
    let context = container.mainContext
    let sameInstant = Date(timeIntervalSince1970: 1_700_000_000)
    // Four records share `viewedAt`. Lower fdcId sorts earlier → evicted first.
    insertRecent(context, fdcId: 10, viewedAt: sameInstant)
    insertRecent(context, fdcId: 20, viewedAt: sameInstant)
    insertRecent(context, fdcId: 30, viewedAt: sameInstant)
    insertRecent(context, fdcId: 40, viewedAt: sameInstant)
    try context.save()

    UserPreferences.enforceRecentFoodsLimit(in: context, limit: 2)

    let survivingIds = Set(
      try context.fetch(FetchDescriptor<RecentFood>()).map(\.fdcId))
    #expect(survivingIds == [30, 40])
  }

  @Test("no-op when count is at or below limit")
  func noOpUnderLimit() throws {
    let container = try makeContainer()
    let context = container.mainContext
    let base = Date(timeIntervalSince1970: 1_700_000_000)
    for index in 0..<3 {
      insertRecent(
        context, fdcId: 1000 + index,
        viewedAt: base.addingTimeInterval(TimeInterval(index)))
    }
    try context.save()

    UserPreferences.enforceRecentFoodsLimit(in: context, limit: 5)

    let remaining = try context.fetch(FetchDescriptor<RecentFood>())
    #expect(remaining.count == 3)
  }
}

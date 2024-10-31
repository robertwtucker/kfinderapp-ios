//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Models
import OSLog
import SwiftData
import SwiftUI

struct HomeTab: View {
  @Environment(\.colorScheme) private var colorScheme

  @Query(sort: \FoodItem.updatedAt, order: .reverse)
  var foods: [FoodItem]

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodsTab.self))

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        HomeHeaderView()
        HomeStatusView()
        RecentFoodsListView()
        Spacer()
      }
      .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
    }
  }
}

struct HomeHeaderView: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 2) {
        Text("Hey there!").font(.footnote)
        Text("Here's what's up...").font(.headline)
      }
      Spacer()
      Color.primary.frame(width: 50, height: 50)
        .clipShape(.circle)
    }
  }
}

#Preview {
  HomeTab()
    .modelContainer(previewContainer)
}


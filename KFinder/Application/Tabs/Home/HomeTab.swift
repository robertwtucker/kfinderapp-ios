//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import OSLog
import SwiftData
import SwiftUI

struct HomeTab: View {
  @Environment(\.colorScheme) private var colorScheme
  @Query(sort: \FoodItem.updatedAt, order: .reverse)
  private var foods: [FoodItem]

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodsTab.self))

  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBaseBackground(for: colorScheme)
        ScrollView(Axis.Set.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 16) {
            Section("home.section.welcome") {
              HomeStatusView()
            }
            .font(.system(size: 20)).bold()
            Section("home.section.recentFoods") {
              RecentFoodsListView()
            }
            .font(.system(size: 20)).bold()
          }
          .padding()
        }
      }
    }
  }
}

#Preview {
  HomeTab()
    .modelContainer(previewContainer)
}

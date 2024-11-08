//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import OSLog
import Services
import SwiftData
import SwiftUI

struct HomeTab: View {
  @Environment(\.colorScheme) private var colorScheme
  @Query(sort: \FoodItem.updatedAt, order: .reverse)
  private var foods: [FoodItem]

//  private let logger = Logger(
//    subsystem: Bundle.main.bundleIdentifier!,
//    category: String(describing: HomeTab.self))

  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBaseBackground(for: colorScheme)
        ScrollView(Axis.Set.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 16) {
            Section(
              header:
                Text("home.section.welcome")
                .font(.system(size: 20)).bold()
            ) {
              TestingStatusView()
            }
            Section(
              header:
                Text("home.section.recentFoods")
                .font(.system(size: 20)).bold()
            ) {
              RecentFoodsListView()
            }
          }
          .padding()
        }
      }
    }
  }
}

#Preview {
  HomeTab()
    .environment(UserPreferences.shared)
    .environment(ReminderManager.shared)
    .modelContainer(previewContainer)
}

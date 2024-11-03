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
  private var foods: [FoodItem]

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodsTab.self))

  var body: some View {
    NavigationStack {
      ZStack {
        // TODO: Externalize/sync these colors with theme definition
        if colorScheme == .dark {
          Color.black
          //          Color(red: 38/255, green: 38/255, blue: 38/255)  //neutral-800
        } else {
          Color(red: 229 / 255, green: 229 / 255, blue: 229 / 255)  //neutral-200
        }
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

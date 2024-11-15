//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import Services
import SwiftUI

struct HomeTab: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    NavigationStack {
      ScrollView(Axis.Set.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 16) {
          Text("home.section.welcome")
            .style(.sectionHeader)
          TestingStatusView()
          VStack(alignment: .leading) {
            Text("home.section.recentFoods")
              .style(.sectionHeader)
            RecentFoodsListView()
              .accentColor(.appForeground(for: colorScheme))
          }
        }
        .padding()
      }
      .background(Color.appBaseBackground(for: colorScheme))
    }
  }
}

#if DEBUG
#Preview {
  HomeTab()
    .environment(UserPreferences.shared)
    .environment(ReminderManager.shared)
    .modelContainer(previewContainer)
}
#endif

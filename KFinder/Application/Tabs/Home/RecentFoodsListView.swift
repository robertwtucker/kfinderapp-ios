//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Models
import OSLog
import SwiftData
import SwiftUI

struct RecentFoodsListView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Query(RecentFoodsListView.fetchDescriptor) var foods: [FoodItem]

  static var fetchDescriptor: FetchDescriptor<FoodItem> {
    var descriptor = FetchDescriptor<FoodItem>(
      sortBy: [
        .init(\.updatedAt, order: .reverse)
      ]
    )
    // TODO: Make this configurable in Settings
    descriptor.fetchLimit = 5
    return descriptor
  }

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: RecentFoodsListView.self))

  @ViewBuilder
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      ForEach(foods, id: \.self) { food in
        VStack {
          Group {
            HStack {
              Text("\(food.name)")
                .font(.headline)
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .padding(.vertical, 24)
                .padding(.horizontal)
              Spacer()
            }
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(
                  colorScheme == .light
                    ? Color.white
                    :  // TODO: Externalize/sync this color with theme definition
                    Color(red: 41 / 255, green: 41 / 255, blue: 41 / 255)  //neutral-750
                  // Color(red: 64/255, green: 64/255, blue: 64/255))  //neutral-700
                  // Color(red: 38/255, green: 38/255, blue: 38/255))  //neutral-800
                )
                .shadow(radius: 1, x: 1, y: 1)
            )
          }
        }
      }
      Spacer()
    }
  }
}

#Preview {
  RecentFoodsListView()
    .modelContainer(previewContainer)
}

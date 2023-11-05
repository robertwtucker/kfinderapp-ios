//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodsListCellView: View {
  @Environment(UserPreferences.self) private var userPreferences
  
  let food: SearchFoodItem
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(food.description)
          .font(.headline)
        Text(food.categoryLine)
          .font(.subheadline)
      }
      Spacer()
      Image(systemName: "ellipsis.circle", variableValue: food.vitaminKAsPercent(of: Int(userPreferences.kTarget)))
        .symbolRenderingMode(.monochrome)
        .foregroundColor(getImageColor())
        .font(.title)
    }
    .padding(.horizontal)
  }
  
  func getImageColor() -> Color {
    switch food.vitaminKAsPercent(of: Int(userPreferences.kTarget)) * 100 {
    case 0:
      return .gray
    case 1..<25:
      return .green
    case 25..<50:
      return .yellow
    case 50..<75:
      return .orange
    case 75...:
      return .red
    default:
      return .gray
    }
  }
}

#Preview {
  FoodsListCellView(food: SearchFoodItem.samples[0])
    .environment(UserPreferences.shared)
}

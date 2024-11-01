//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Models
import Services

struct FoodsListCellView: View {
  @Environment(UserPreferences.self) private var userPreferences
  
  let food: FoodItem
  
  var body: some View {
    let displayHelper = FoodDisplayHelper(food)
    
    HStack {
      VStack(alignment: .leading) {
        Text(food.name)
          .font(.headline)
        Text(food.category ?? "")
          .font(.subheadline)
      }
      Spacer()
      Image(systemName: "ellipsis.circle", variableValue: displayHelper.vitaminKAsPercent(of: Int(userPreferences.kTarget)))
        .symbolRenderingMode(.monochrome)
        .foregroundColor(getImageColor())
        .font(.title)
    }
    .padding(.horizontal)
  }
  
  func getImageColor() -> Color {
    let displayHelper = FoodDisplayHelper(food)
    
    switch displayHelper.vitaminKAsPercent(of: Int(userPreferences.kTarget)) * 100 {
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
  FoodsListCellView(food: FoodItem.samples[0])
    .environment(UserPreferences.shared)
}

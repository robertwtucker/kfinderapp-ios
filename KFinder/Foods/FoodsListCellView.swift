//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodsListCellView: View {
  let food: SearchFoodItem
  
  init(for food: SearchFoodItem) {
    self.food = food
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(food.description)
          .font(.headline)
        Text(food.categoryLine)
          .font(.subheadline)
      }
      Spacer()
      Image(systemName: "ellipsis.circle", variableValue: food.vitaminKAsPercent(of: 90))
        .symbolRenderingMode(.monochrome)
        .foregroundColor(getImageColor())
        .font(.title)
    }
    .padding(.horizontal)
  }
  
  func getImageColor() -> Color {
    switch food.vitaminKAsPercent(of: 90)*100 {
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

struct FoodItemCellView_Previews: PreviewProvider {
  static var previews: some View {
    FoodsListCellView(for: SearchFoodItem.samples[0])
  }
}

//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodsListCellView: View {
  @AppStorage(StorageKeys.kTarget.rawValue) private var kTarget: Int = 120
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
      Image(systemName: "ellipsis.circle", variableValue: food.vitaminKAsPercent(of: kTarget))
        .symbolRenderingMode(.monochrome)
        .foregroundColor(getImageColor())
        .font(.title)
    }
    .padding(.horizontal)
  }
  
  func getImageColor() -> Color {
    switch food.vitaminKAsPercent(of: kTarget) * 100 {
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
    FoodsListCellView(food: SearchFoodItem.samples[0])
  }
}

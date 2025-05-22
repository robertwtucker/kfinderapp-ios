//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
import Models
import Services
import SwiftUI

struct FoodsListView: View {
  var foods: [FoodItem]

  var body: some View {
    List(foods, id: \.self) { food in
      NavigationLink(value: food) {
        FoodsListCellView(food: food)
      }
    }
    .navigationDestination(for: FoodItem.self) { food in
      FoodDetailView(food: food)
    }
  }
}

struct FoodsListCellView: View {
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
      Image(
        systemName: "ellipsis.circle",
        variableValue: displayHelper.vitaminKAsPercent(
          of: Int(Defaults[.dailyKTarget])
        )
      )
      .symbolRenderingMode(.monochrome)
      .foregroundColor(getImageColor())
      .font(.title)
    }
    .padding(.horizontal)
  }

  func getImageColor() -> Color {
    let displayHelper = FoodDisplayHelper(food)

    switch displayHelper.vitaminKAsPercent(
      of: Int(Defaults[.dailyKTarget])
    )
      * 100 {
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

#if DEBUG
  #Preview {
    FoodsListView(foods: FoodItem.samples)
      .modelContainer(previewContainer)
  }
#endif

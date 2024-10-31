//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Models

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

#Preview {
  FoodsListView(foods: FoodItem.samples)
}

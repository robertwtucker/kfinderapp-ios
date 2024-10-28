//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Models
import SwiftData

struct FoodDetailView: View {
  @Environment(\.modelContext) private var context
  
  let food: FoodItem
  
  var body: some View {
    let helper = FoodDisplayHelper(food)
    
    VStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(food.name)
          .font(.title)
        Text(helper.category)
          .font(.headline)
        Text(helper.extra)
          .font(.callout)
        HStack {
          Text(helper.citation).font(.footnote)
          Spacer()
          Text("foods.portion.default").font(.headline)
        }.padding(.top, 4)
      }
      .padding(.horizontal, 24)
      FoodNutrientListView(food: food)
    }
    .onAppear {
      upsert(food)
    }
  }
  
  private func upsert(_ food: FoodItem) {
    food.dateUpdated = Date.now
    context.insert(food)
  }
}


#Preview {
  FoodDetailView(food: FoodItem.samples[0])
}

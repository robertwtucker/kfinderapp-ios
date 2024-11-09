//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import OSLog
import SwiftData
import SwiftUI

struct FoodDetailView: View {
    @Environment(\.modelContext) private var context
    @Query private var foods: [FoodItem]
    @State var food: FoodItem

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: FoodDetailView.self))

    init(food: FoodItem) {
        self.food = food
        let id = food.id
        _foods = Query(filter: #Predicate<FoodItem> { $0.id == id })
    }

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
            if let stored = foods.first {
                logger.debug("Updating stored food item: '[\(food.id)]  \(food.name)'")
                stored.updatedAt = Date.now
            } else {
                logger.debug("Storing new food item: '[\(food.id)]  \(food.name)'")
                food.updatedAt = Date.now
                context.insert(food)
            }
        }
    }
}

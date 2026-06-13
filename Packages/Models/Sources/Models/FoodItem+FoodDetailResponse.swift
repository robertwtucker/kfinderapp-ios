//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

extension FoodItem {
  // Maps the `/food/{fdcId}?format=full` payload (issue #96). Filters out
  // header rows in `foodNutrients` (Proximates, Minerals, …) that have no
  // `id`/`amount`, and prefers `modifier` text for portions because the
  // FNDDS `portionDescription` is usually a generic "Quantity not specified".
  public convenience init(from response: FoodDetailResponse) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "M/d/yyyy"

    let extra = response.foodAttributes?
      .filter { $0.foodAttributeType?.name == "Additional Description" }
      .compactMap { attribute -> (Int, String)? in
        guard let value = attribute.value, !value.isEmpty else { return nil }
        return (attribute.sequenceNumber ?? Int.max, value)
      }
      .sorted { $0.0 < $1.0 }
      .map { $0.1 }
      .joined(separator: ";")
      .nonEmpty

    let nutrients: [FoodNutrient] = response.foodNutrients.compactMap { entry in
      guard let nutrient = entry.nutrient,
            let amount = entry.amount,
            let number = nutrient.number else {
        return nil
      }
      return FoodNutrient(
        number: number,
        name: nutrient.name ?? "",
        unitName: nutrient.unitName ?? "",
        value: amount)
    }

    let measures: [FoodMeasure] = response.foodPortions?
      .sorted { ($0.sequenceNumber ?? .max) < ($1.sequenceNumber ?? .max) }
      .map { portion in
        let text = portion.modifier?.nonEmpty
          ?? portion.portionDescription
          ?? ""
        return FoodMeasure(
          id: portion.id,
          text: text,
          gramWeight: portion.gramWeight,
          rank: portion.sequenceNumber ?? 0)
      } ?? []

    self.init(
      id: response.fdcId,
      name: response.description,
      extra: extra,
      dataType: response.dataType ?? response.foodClass
        ?? FoodSearchCriteria.DataSet.unspecified.rawValue,
      category: response.wweiaFoodCategory?.wweiaFoodCategoryDescription,
      publishedOn: response.publicationDate
        .flatMap { dateFormatter.date(from: $0) } ?? Date.distantPast,
      nutrients: nutrients,
      measures: measures)
  }
}

extension String {
  fileprivate var nonEmpty: String? { isEmpty ? nil : self }
}

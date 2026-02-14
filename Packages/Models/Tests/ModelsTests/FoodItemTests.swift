//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Testing

@testable import Models

// MARK: - SearchFoodItem Tests

@Suite("SearchFoodItem")
struct SearchFoodItemTests {

  @Suite("foodDataType")
  struct FoodDataType {
    @Test("survey returns Survey")
    func survey() {
      let item = SearchFoodItem(
        fdcId: 1, dataType: .survey, description: "Test")
      #expect(item.foodDataType == "Survey")
    }

    @Test("branded returns Branded")
    func branded() {
      let item = SearchFoodItem(
        fdcId: 1, dataType: .branded, description: "Test")
      #expect(item.foodDataType == "Branded")
    }

    @Test("foundation returns Foundation")
    func foundation() {
      let item = SearchFoodItem(
        fdcId: 1, dataType: .foundation, description: "Test")
      #expect(item.foodDataType == "Foundation")
    }

    @Test("legacy returns SR Legacy")
    func legacy() {
      let item = SearchFoodItem(
        fdcId: 1, dataType: .legacy, description: "Test")
      #expect(item.foodDataType == "SR Legacy")
    }

    @Test("unspecified returns Unspecified")
    func unspecified() {
      let item = SearchFoodItem(
        fdcId: 1, dataType: .unspecified, description: "Test")
      #expect(item.foodDataType == "Unspecified")
    }
  }

  @Suite("Identifiable and Hashable")
  struct Identity {
    @Test("id returns fdcId")
    func identifiable() {
      let item = SearchFoodItem(
        fdcId: 12345, dataType: .survey, description: "Test")
      #expect(item.id == 12345)
    }

    @Test("equality based on fdcId")
    func equality() {
      let item1 = SearchFoodItem(
        fdcId: 100, dataType: .survey, description: "Food A")
      let item2 = SearchFoodItem(
        fdcId: 100, dataType: .branded, description: "Food B")
      #expect(item1 == item2)
    }

    @Test("inequality for different fdcId")
    func inequality() {
      let item1 = SearchFoodItem(
        fdcId: 100, dataType: .survey, description: "Food")
      let item2 = SearchFoodItem(
        fdcId: 200, dataType: .survey, description: "Food")
      #expect(item1 != item2)
    }
  }
}

// MARK: - FoodItem Tests

@Suite("FoodItem")
struct FoodItemTests {

  @Suite("init from SearchFoodItem")
  struct InitFromSearch {
    @Test("maps basic fields")
    func mapsBasicFields() {
      let search = SearchFoodItem(
        fdcId: 12345,
        dataType: .survey,
        description: "Test Food",
        additionalDescriptions: "extra info",
        foodCategory: "Vegetables"
      )
      let item = FoodItem(from: search)
      #expect(item.id == 12345)
      #expect(item.name == "Test Food")
      #expect(item.extra == "extra info")
      #expect(item.dataType == "Survey")
      #expect(item.category == "Vegetables")
    }

    @Test("parses valid published date")
    func parsesDate() {
      let search = SearchFoodItem(
        fdcId: 1,
        dataType: .survey,
        description: "Test",
        publishedDate: "2022-10-28"
      )
      let item = FoodItem(from: search)
      let calendar = Calendar.current
      let components = calendar.dateComponents(
        [.year, .month, .day], from: item.publishedOn!)
      #expect(components.year == 2022)
      #expect(components.month == 10)
      #expect(components.day == 28)
    }

    @Test("falls back to distantPast for nil date")
    func nilDate() {
      let search = SearchFoodItem(
        fdcId: 1,
        dataType: .survey,
        description: "Test",
        publishedDate: nil
      )
      let item = FoodItem(from: search)
      #expect(item.publishedOn == Date.distantPast)
    }

    @Test("falls back to distantPast for malformed date")
    func malformedDate() {
      let search = SearchFoodItem(
        fdcId: 1,
        dataType: .survey,
        description: "Test",
        publishedDate: "not-a-date"
      )
      let item = FoodItem(from: search)
      #expect(item.publishedOn == Date.distantPast)
    }

    @Test("maps nutrients from search")
    func mapsNutrients() {
      let search = SearchFoodItem(
        fdcId: 1,
        dataType: .survey,
        description: "Test",
        foodNutrients: [
          SearchFoodNutrient(
            _id: 1003, name: "Protein", number: "203",
            unitName: "G", value: 24.7, indentLevel: 1),
          SearchFoodNutrient(
            _id: 1004, name: "Fat", number: "204",
            unitName: "G", value: 17.6, indentLevel: 1),
        ]
      )
      let item = FoodItem(from: search)
      #expect(item.nutrients?.count == 2)
      #expect(item.nutrients?[0].name == "Protein")
      #expect(item.nutrients?[1].name == "Fat")
    }

    @Test("maps measures from search")
    func mapsMeasures() {
      let search = SearchFoodItem(
        fdcId: 1,
        dataType: .survey,
        description: "Test",
        foodMeasures: [
          SearchFoodMeasure(
            disseminationText: "1 cup", gramWeight: 200,
            id: 1, rank: 1)
        ]
      )
      let item = FoodItem(from: search)
      #expect(item.measures?.count == 1)
      #expect(item.measures?[0].text == "1 cup")
    }

    @Test("defaults to empty arrays for nil nutrients and measures")
    func nilNutrientsAndMeasures() {
      let search = SearchFoodItem(
        fdcId: 1,
        dataType: .survey,
        description: "Test"
      )
      let item = FoodItem(from: search)
      #expect(item.nutrients?.isEmpty == true)
      #expect(item.measures?.isEmpty == true)
    }
  }
}

// MARK: - Reminder Tests

@Suite("Reminder")
struct ReminderTests {

  @Test("initializes with default values")
  func defaults() {
    let date = Date.now
    let reminder = Reminder(title: "Test", dueDate: date)
    #expect(reminder.title == "Test")
    #expect(reminder.dueDate == date)
    #expect(reminder.notes == nil)
    #expect(reminder.isCompleted == false)
    #expect(!reminder.id.isEmpty)
  }

  @Test("two reminders have different IDs")
  func uniqueIds() {
    let date = Date.now
    let rem1 = Reminder(title: "Test", dueDate: date)
    let rem2 = Reminder(title: "Test", dueDate: date)
    #expect(rem1.id != rem2.id)
  }

  @Test("equality compares all fields")
  func equatable() {
    let date = Date.now
    let rem1 = Reminder(
      id: "same-id", title: "Test", dueDate: date, notes: "Note")
    let rem2 = Reminder(
      id: "same-id", title: "Test", dueDate: date, notes: "Note")
    #expect(rem1 == rem2)
  }

  @Test("inequality when fields differ")
  func notEqual() {
    let date = Date.now
    let rem1 = Reminder(
      id: "same-id", title: "Test A", dueDate: date)
    let rem2 = Reminder(
      id: "same-id", title: "Test B", dueDate: date)
    #expect(rem1 != rem2)
  }
}

//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import Services
import Testing

@testable import KFinder

// MARK: - FoodDisplayHelper Tests

@Suite("FoodDisplayHelper")
struct FoodDisplayHelperTests {

  // MARK: - Vitamin K Filtering

  @Suite("nutrientsWithVitaminK")
  struct VitaminKFiltering {
    @Test("includes nutrient 430 (phylloquinone)")
    func includes430() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "430", name: "Vitamin K (phylloquinone)",
            unitName: "UG", value: 74.1),
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsWithVitaminK.count == 1)
      #expect(helper.nutrientsWithVitaminK[0].number == "430")
    }

    @Test("includes nutrient 428 (menaquinone-4)")
    func includes428() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "428", name: "Menaquinone-4",
            unitName: "UG", value: 5.0)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsWithVitaminK.count == 1)
    }

    @Test("includes nutrient 429 (dihydrophylloquinone)")
    func includes429() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "429", name: "Dihydrophylloquinone",
            unitName: "UG", value: 3.0)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsWithVitaminK.count == 1)
    }

    @Test("excludes non-Vitamin K nutrients")
    func excludesOthers() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7),
          FoodNutrient(
            number: "431", name: "Folic acid", unitName: "UG", value: 0.0)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsWithVitaminK.isEmpty)
    }

    @Test("returns empty when nutrients is nil")
    func nilNutrients() {
      let food = FoodItem(id: 1, name: "Test", dataType: "Survey")
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsWithVitaminK.isEmpty)
    }

    @Test("finds multiple Vitamin K forms")
    func multipleVitaminKForms() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "428", name: "Menaquinone-4",
            unitName: "UG", value: 5.0),
          FoodNutrient(
            number: "429", name: "Dihydrophylloquinone",
            unitName: "UG", value: 3.0),
          FoodNutrient(
            number: "430", name: "Vitamin K (phylloquinone)",
            unitName: "UG", value: 74.1),
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsWithVitaminK.count == 3)
    }
  }

  // MARK: - nutrientsOtherThanVitaminK

  @Suite("nutrientsOtherThanVitaminK")
  struct NonVitaminKFiltering {
    @Test("excludes Vitamin K nutrients")
    func excludesVitaminK() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "430", name: "Vitamin K",
            unitName: "UG", value: 74.1),
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7),
          FoodNutrient(
            number: "208", name: "Energy", unitName: "KCAL", value: 271)
        ])
      let helper = FoodDisplayHelper(food)
      let result = helper.nutrientsOtherThanVitaminK
      #expect(result.count == 2)
      #expect(result.allSatisfy { $0.number != "430" })
    }

    @Test("returns empty when nutrients is nil")
    func nilNutrients() {
      let food = FoodItem(id: 1, name: "Test", dataType: "Survey")
      let helper = FoodDisplayHelper(food)
      #expect(helper.nutrientsOtherThanVitaminK.isEmpty)
    }
  }

  // MARK: - Sum of Vitamin K

  @Suite("sumOfVitaminKValues")
  struct SumVitaminK {
    @Test("sums all Vitamin K nutrient values")
    func sumsMultiple() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "428", name: "Menaquinone-4",
            unitName: "UG", value: 5.0),
          FoodNutrient(
            number: "430", name: "Vitamin K",
            unitName: "UG", value: 74.1),
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(abs(helper.sumOfVitaminKValues - 79.1) < 0.001)
    }

    @Test("is zero when no Vitamin K nutrients")
    func zeroWhenNone() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.sumOfVitaminKValues == 0.0)
    }
  }

  // MARK: - Vitamin K as Percent

  @Suite("vitaminKAsPercent")
  struct VitaminKPercent {
    @Test("calculates correct percentage of daily target")
    func correctPercent() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "430", name: "Vitamin K",
            unitName: "UG", value: 60.0)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(abs(helper.vitaminKAsPercent(of: 120) - 0.5) < 0.001)
    }

    @Test("returns 0 when no Vitamin K")
    func zeroWhenNone() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "203", name: "Protein", unitName: "G", value: 24.7)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(helper.vitaminKAsPercent(of: 120) == 0.0)
    }

    @Test("returns value > 1 when exceeding target")
    func exceedsTarget() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        nutrients: [
          FoodNutrient(
            number: "430", name: "Vitamin K",
            unitName: "UG", value: 240.0)
        ])
      let helper = FoodDisplayHelper(food)
      #expect(abs(helper.vitaminKAsPercent(of: 120) - 2.0) < 0.001)
    }
  }

  // MARK: - Citation

  @Suite("citation")
  struct CitationTests {
    @Test("formats with publication date")
    func withDate() {
      var components = DateComponents()
      components.year = 2022
      components.month = 10
      components.day = 28
      let date = Calendar.current.date(from: components)!

      let food = FoodItem(
        id: 2_341_130, name: "Test",
        dataType: "Survey", publishedOn: date)
      let helper = FoodDisplayHelper(food)
      #expect(helper.citation == "Survey/2341130/Pub:2022-10-28")
    }

    @Test("formats without publication date")
    func withoutDate() {
      let food = FoodItem(
        id: 2_341_130, name: "Test", dataType: "Survey")
      let helper = FoodDisplayHelper(food)
      #expect(helper.citation == "Survey/2341130")
    }
  }

  // MARK: - Category and Extra

  @Suite("category and extra")
  struct CategoryExtraTests {
    @Test("capitalizes category")
    func capitalizesCategory() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey",
        category: "cheese")
      let helper = FoodDisplayHelper(food)
      #expect(helper.category == "Cheese")
    }

    @Test("returns empty string for nil category")
    func nilCategory() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey")
      let helper = FoodDisplayHelper(food)
      #expect(helper.category == "")
    }

    @Test("capitalizes extra")
    func capitalizesExtra() {
      let food = FoodItem(
        id: 1, name: "Test", extra: "lowfat;part skim",
        dataType: "Survey")
      let helper = FoodDisplayHelper(food)
      #expect(helper.extra == "Lowfat;Part Skim")
    }

    @Test("returns empty string for nil extra")
    func nilExtra() {
      let food = FoodItem(
        id: 1, name: "Test", dataType: "Survey")
      let helper = FoodDisplayHelper(food)
      #expect(helper.extra == "")
    }
  }
}

// MARK: - TestReminderModel Tests

@Suite("TestReminderModel")
@MainActor
struct TestReminderModelTests {

  @Test("isDueOn returns _unset_ when reminder is nil")
  func isDueOnNil() {
    let model = TestReminderModel()
    #expect(model.isDueOn == "_unset_")
  }

  @Test("isDueOn formats the due date")
  func isDueOnFormatted() {
    var components = DateComponents()
    components.year = 2024
    components.month = 6
    components.day = 15
    let date = Calendar.current.date(from: components)!

    let reminder = Reminder(title: "Test", dueDate: date)
    let model = TestReminderModel(reminder)
    let result = model.isDueOn
    #expect(!result.isEmpty)
    #expect(result != "_unset_")
  }

  @Test("isDueOn excludes time from formatting")
  func isDueOnExcludesTime() {
    var components = DateComponents()
    components.year = 2024
    components.month = 6
    components.day = 15
    components.hour = 8
    let morning = Calendar.current.date(from: components)!
    components.hour = 20
    let evening = Calendar.current.date(from: components)!

    let morningModel = TestReminderModel(
      Reminder(title: "Test", dueDate: morning))
    let eveningModel = TestReminderModel(
      Reminder(title: "Test", dueDate: evening))
    #expect(morningModel.isDueOn == eveningModel.isDueOn)
  }

  @Test("isCompleted returns false when reminder is nil")
  func isCompletedNil() {
    let model = TestReminderModel()
    #expect(model.isCompleted() == false)
  }

  @Test("isCompleted returns reminder's completion status")
  func isCompletedReflectsReminder() {
    let completed = Reminder(
      title: "Test", dueDate: Date.now, isCompleted: true)
    let model = TestReminderModel(completed)
    #expect(model.isCompleted() == true)
  }

  @Test("isOverDue returns false when reminder is nil")
  func isOverDueNil() {
    let model = TestReminderModel()
    #expect(model.isOverDue() == false)
  }

  @Test("isOverDue returns true for past due date")
  func isOverDuePast() {
    let pastDate = Date.now.addingTimeInterval(-86400)
    let reminder = Reminder(title: "Test", dueDate: pastDate)
    let model = TestReminderModel(reminder)
    #expect(model.isOverDue() == true)
  }

  @Test("isOverDue returns false for future due date")
  func isOverDueFuture() {
    let futureDate = Date.now.addingTimeInterval(86400)
    let reminder = Reminder(title: "Test", dueDate: futureDate)
    let model = TestReminderModel(reminder)
    #expect(model.isOverDue() == false)
  }
}

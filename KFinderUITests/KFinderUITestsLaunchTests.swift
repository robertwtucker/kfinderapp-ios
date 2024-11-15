//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import XCTest

final class KFinderUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        addUIInterruptionMonitor(withDescription: "System Dialog") {
            (alert) -> Bool in
            let permissionText = "Would Like to Access Your Reminders"
            let predicate = NSPredicate(format: "label CONTAINS %@", permissionText)
            if alert.staticTexts.matching(predicate).firstMatch.exists {
                alert.buttons["Allow"].tap()
            }
            return true
        }
        app.tap()

        let device = XCUIDevice.shared
        device.orientation = .portrait

        // Screenshot: Food search results
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Foods"].tap()
        let foodNameOrKeywordSSearchField = app.navigationBars[
            "_TtGC7SwiftUI32NavigationStackHosting"
        ].searchFields["Food name or keyword(s)"]
        let collectionViewsQuery = app.collectionViews
        foodNameOrKeywordSSearchField.tap()
        foodNameOrKeywordSSearchField.typeText("cashews\n")
        if collectionViewsQuery.buttons["Cashews, salted, Nuts and seeds"]
            .waitForExistence(timeout: 2) {
            snapshot("00FoodSearch")
        } else {
            throw XCTSkip("Food search failed")
        }

        // Screen shot: Food detail
        collectionViewsQuery.buttons["Cashews, salted, Nuts and seeds"].tap()
        snapshot("01FoodDetail")

        // Screen shot: Create reminder
        tabBar.buttons["house"].tap()
        if app.scrollViews.otherElements.buttons["Enable"].exists {
            app.scrollViews.otherElements.buttons["Enable"].tap()
        }

        if app.scrollViews.otherElements.buttons["Create"].exists {
            app.scrollViews.otherElements.buttons["Create"].tap()
            snapshot("02CreateReminder")
        }

        // Screen shot: Home tab
        app.buttons["Save"].tap()
        snapshot("03HomeTab")
    }
}

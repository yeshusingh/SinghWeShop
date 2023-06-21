//
//  ItemDetailScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class ItemDetailScreenUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var app: XCUIApplication!
  // The setUpWithError methods are run for each individual test, hence it better to setup/assign value to the Application there as it will
  // a fresh start for each test run.

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()

    XCUIDevice.shared.orientation = .portrait
    app.loginSetup()
    XCTAssert(app.tabBars["Tab Bar"].waitForExistence(timeout: 7), "Login unsuccessful during setup.")
  }

  override func tearDown() {
    app.logoutStep()
  }

  func test_itemDetailUIElements() throws {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCTAssert(app.collectionViews.cells.firstMatch.waitForExistence(timeout: 10))

    app.collectionViews.cells.firstMatch.tap()

    XCTAssert(app.scrollViews.element.exists)
    XCTAssertEqual(app.scrollViews.staticTexts.count, 5)

    XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)
    app.scrollViews.buttons["Add to Cart"].tap()

    app.navigationBars.firstMatch.buttons["WeShop"].tap()
  }

  func test_detailViewDiffOrientation() throws {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCTAssert(app.collectionViews.cells.firstMatch.waitForExistence(timeout: 10))

    XCUIDevice.shared.orientation = .landscapeLeft

    app.collectionViews.cells.firstMatch.tap()

    XCTAssert(app.scrollViews.element.exists)
    XCTAssertEqual(app.scrollViews.staticTexts.count, 5)

    XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)

    app.navigationBars.firstMatch.buttons["WeShop"].tap()
    XCUIDevice.shared.orientation = .portrait
  }
}

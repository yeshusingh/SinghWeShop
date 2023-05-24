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

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  func test_itemDetailUIElements() throws {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    // try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")
    try XCTSkipUnless(app.collectionViews.cells.firstMatch.exists, "Minimum 1 item required to test Item Detail View")

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

    // try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")
    try XCTSkipUnless(app.collectionViews.cells.firstMatch.exists, "Minimum 1 item required to test Item Detail View")

    XCUIDevice.shared.orientation = .landscapeLeft

    app.collectionViews.cells.firstMatch.tap()

    XCTAssert(app.scrollViews.element.exists)
    XCTAssertEqual(app.scrollViews.staticTexts.count, 5)

    XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)

    app.navigationBars.firstMatch.buttons["WeShop"].tap()
    XCUIDevice.shared.orientation = .portrait
  }
}

//
//  CartScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class CartScreenUITests: XCTestCase {
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

  func test_cartTabUIElements() {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Cart"].exists)
    tabBar.buttons["Cart"].tap()

    XCTAssert(app.navigationBars["My Cart"].exists)

    let weshopNavigationBar = app.navigationBars["My Cart"]
    XCTAssert(weshopNavigationBar.staticTexts["My Cart"].exists)

    XCTAssert(app.scrollViews.otherElements.buttons["Order Now"].exists)
  }

  func test_checkoutButton() {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Cart"].exists)

    let cartButton = tabBar.buttons["Cart"]
    cartButton.tap()

    XCTAssert(app.scrollViews.otherElements.buttons["Order Now"].exists)
    app.scrollViews.otherElements.buttons["Order Now"].tap()
  }
}

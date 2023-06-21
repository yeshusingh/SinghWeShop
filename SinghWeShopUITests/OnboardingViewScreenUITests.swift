//
//  OnboardingViewScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class OnboardingViewScreenUITests: XCTestCase {
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
    XCTAssert(app.tabBars["Tab Bar"].waitForExistence(timeout: 5), "Login unsuccessful during setup.")
  }

  func test_OnboardingView() {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCTAssert(app.navigationBars["WeShop"].exists)
    let weshopNavigationBar = app.navigationBars["WeShop"]
    XCTAssert(weshopNavigationBar.buttons["Info"].exists)
    weshopNavigationBar.buttons["Info"].tap()

    let elementsQuery = app.scrollViews.otherElements
    XCTAssert(elementsQuery.images["IconPicture"].exists)
    XCTAssert(elementsQuery.staticTexts["This is where you come to do all your shopping."].exists)

    XCTAssert(elementsQuery.staticTexts[
      """
      Browse the items - You can view items and tap on them to view more details.
      """
      ].exists)
    XCTAssert(elementsQuery.staticTexts[
      """
      Add items to the cart as you continue shopping. \
      And the cart will hold all added items in place for checkout.
      """
      ].exists)
    XCTAssert(elementsQuery.staticTexts[
      """
      All applicable discounts are applied in the cart at the time \
      of checkout.
      """
      ].exists)
  }

  func test_onboardingViewDiffOrientation() throws {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCUIDevice.shared.orientation = .landscapeLeft

    XCTAssert(app.navigationBars["WeShop"].exists)
    let weshopNavigationBar = app.navigationBars["WeShop"]
    XCTAssert(weshopNavigationBar.buttons["Info"].exists)
    weshopNavigationBar.buttons["Info"].tap()

    let elementsQuery = app.scrollViews.otherElements
    XCTAssert(elementsQuery.images["IconPicture"].exists)
    XCTAssert(elementsQuery.staticTexts["This is where you come to do all your shopping."].exists)

    XCTAssert(elementsQuery.staticTexts[
      """
      Browse the items - You can view items and tap on them to view more details.
      """].exists)

    XCTAssert(elementsQuery.staticTexts[
      """
      Add items to the cart as you continue shopping. \
      And the cart will hold all added items in place for checkout.
      """].exists)

    XCTAssert(elementsQuery.staticTexts[
      """
      All applicable discounts are applied in the cart at the time \
      of checkout.
      """
      ].exists)

    XCUIDevice.shared.orientation = .portrait
  }
}

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

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
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
      Browse the items - You can view items on the homepage and \
      click them to get more details.
      """
      ].exists)
    XCTAssert(elementsQuery.staticTexts[
      """
      Add items to the cart as you continue shopping. \
      And the cart will hold all added items in place for checkout.
      """
      ].exists)
    XCTAssert(elementsQuery.staticTexts["You can apply discount coupons in the cart at the time of checkout."].exists)

    app.navigationBars.firstMatch.buttons["WeShop"].tap()
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
      Browse the items - You can view items on the homepage \
      and click them to get more details.
      """].exists)

    XCTAssert(elementsQuery.staticTexts[
      """
      Add items to the cart as you continue shopping. \
      And the cart will hold all added items in place for checkout.
      """].exists)
    XCTAssert(elementsQuery.staticTexts["You can apply discount coupons in the cart at the time of checkout."].exists)

    app.navigationBars.firstMatch.buttons["WeShop"].tap()
    XCUIDevice.shared.orientation = .portrait
  }
}

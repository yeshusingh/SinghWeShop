//
//  SinghWeShopUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/14/23.
//

import XCTest
@testable import SinghWeShop

final class SinghWeShopUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var app: XCUIApplication!

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  func test_allTabsExist() {
    let tabBar = app.tabBars["Tab Bar"]

    XCTAssert(tabBar.buttons["Home"].exists)
    XCTAssert(tabBar.buttons["Discover"].exists)
    XCTAssert(tabBar.buttons["Cart"].exists)
    XCTAssert(tabBar.buttons["Account"].exists)
    XCTAssertFalse(tabBar.buttons["Info"].exists)
  }
}

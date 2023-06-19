//
//  AccountViewScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/22/23.
//

import XCTest

final class AccountViewScreenUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var app: XCUIApplication!
  // The setUpWithError methods are run for each individual test, hence it better to setup/assign value to the Application there as it will
  // a fresh start for each test run.

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  func test_screenElements() {
    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Account"].exists)

    tabBar.buttons["Account"].tap()
    XCTAssert(app.navigationBars.element.exists)
    let object = app.collectionViews.cells.otherElements

    if app.collectionViews.cells.count == 1 {
      let matchingElement = object.children(matching: .staticText).matching(identifier: "Account Info not available.")
      XCTAssert(matchingElement.element.exists)
    } else if app.collectionViews.cells.count == 11 {
      XCTAssert(object.children(matching: .staticText).matching(identifier: "ACCOUNT DETAILS").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "Member ID").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "User Details".uppercased()).element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "Username").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "Name").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "Email").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "Phone").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "SHIPPING ADDRESS").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "Street").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "City").element.exists)
      XCTAssert(object.children(matching: .staticText).matching(identifier: "ZipCode").element.exists)
    } else {
      XCTFail("Unverified UI conditon detected.")
    }
  }
}

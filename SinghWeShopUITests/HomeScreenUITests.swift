//
//  HomeScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class HomeScreenUITests: XCTestCase {
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
  }

  override func tearDown() {
    app.logoutStep()
  }

  func test_homeTabUIElements() {
    XCTAssertTrue(app.tabBars["Tab Bar"].waitForExistence(timeout: 10))

    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCTAssert(app.navigationBars["WeShop"].exists)

    let weshopNavigationBar = app.navigationBars["WeShop"]
    XCTAssert(weshopNavigationBar.staticTexts["WeShop"].exists)
    XCTAssert(weshopNavigationBar.buttons["Info"].exists)
    XCTAssert(weshopNavigationBar.searchFields["Search"].exists)
  }

  func test_addThenRemoveItemInCart() throws {
    XCTAssertTrue(app.tabBars["Tab Bar"].waitForExistence(timeout: 10))

    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCTAssert(app.collectionViews.cells.firstMatch.waitForExistence(timeout: 10))

    app.collectionViews.cells.firstMatch.tap()

    XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)
    app.scrollViews.buttons["Add to Cart"].tap()

    app.navigationBars.firstMatch.buttons["WeShop"].tap()

    XCTAssert(tabBar.buttons["Cart"].exists)
    tabBar.buttons["Cart"].tap()

    XCTAssert(app.scrollViews.buttons["Remove"].exists, "Expected a remove button as 1 item added to cart.")
    app.scrollViews.buttons["Remove"].tap()

    XCTAssertFalse(app.scrollViews.buttons["Remove"].exists)
  }

  func test_swipeActionToAddToCart() throws {
    XCTAssertTrue(app.tabBars["Tab Bar"].waitForExistence(timeout: 10))

    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()
    XCUIDevice.shared.orientation = .portrait

    XCTAssert(app.collectionViews.cells.firstMatch.waitForExistence(timeout: 10))

    let itemToSwipe = app.collectionViews.cells.firstMatch
    itemToSwipe.swipeRight()
    app.collectionViews.buttons["AddToCart"].tap()

    XCTAssert(tabBar.buttons["Cart"].exists)
    tabBar.buttons["Cart"].tap()

    XCTAssert(app.scrollViews.buttons["Remove"].exists, "Expected a remove button as 1 item added to cart." )
  }

  func test_seachInHomeTab() {
    XCTAssertTrue(app.tabBars["Tab Bar"].waitForExistence(timeout: 10))

    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    let weshopNavigationBar = app.navigationBars["WeShop"]
    let searchSearchField = weshopNavigationBar.searchFields["Search"]
    searchSearchField.tap()

    app.typeText("P")

    searchSearchField.buttons["Clear text"].tap()
    weshopNavigationBar.buttons["Cancel"].tap()

    XCTAssert(tabBar.buttons["Home"].isSelected)
  }

  func test_detailViewFromHomeTab() throws {
    XCTAssertTrue(app.tabBars["Tab Bar"].waitForExistence(timeout: 10))

    let tabBar = app.tabBars["Tab Bar"]
    XCTAssert(tabBar.buttons["Home"].exists)
    tabBar.buttons["Home"].tap()

    XCTAssert(app.collectionViews.cells.firstMatch.waitForExistence(timeout: 10))

    XCTAssert(app.collectionViews.cells.firstMatch.exists)
    app.collectionViews.cells.firstMatch.tap()

    XCTAssert(app.scrollViews.element.exists)
    XCTAssertEqual(app.scrollViews.staticTexts.count, 5)
    XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)

    app.navigationBars.firstMatch.buttons["WeShop"].tap()
  }
}

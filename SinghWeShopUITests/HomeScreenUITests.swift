//
//  HomeScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class HomeScreenUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func test_homeTabUIElements() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        XCUIDevice.shared.orientation = .portrait
        
        XCTAssert(app.navigationBars["WeShop"].exists)
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        XCTAssert(weshopNavigationBar.staticTexts["WeShop"].exists)
        XCTAssert(weshopNavigationBar.buttons["Info"].exists)
        XCTAssert(weshopNavigationBar.searchFields["Search"].exists)
        
        XCTAssertGreaterThanOrEqual(app.collectionViews.cells.count, 5)
    }
    
    func test_addThenRemoveItemInCart() throws {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()

        try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")

        app.collectionViews.cells.firstMatch.tap()

        XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)
        app.scrollViews.buttons["Add to Cart"].tap()
        
        app.navigationBars.firstMatch.buttons["WeShop"].tap()
       
        XCTAssert(tabBar.buttons["Cart"].exists)
        tabBar.buttons["Cart"].tap()

        XCTAssert(app.scrollViews.buttons["Remove"].exists,"Expected a remove button as 1 item added to cart.")
        app.scrollViews.buttons["Remove"].tap()
        
        XCTAssertFalse(app.scrollViews.buttons["Remove"].exists)
    }
    
    func test_swipeActionToAddToCart() throws {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        XCUIDevice.shared.orientation = .portrait
        
        try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")
        
        let itemToSwipe = app.collectionViews.cells.firstMatch
        itemToSwipe.swipeRight()
        app.collectionViews.buttons["AddToCart"].tap()
        
        XCTAssert(tabBar.buttons["Cart"].exists)
        tabBar.buttons["Cart"].tap()
        
        XCTAssert(app.scrollViews.buttons["Remove"].exists,"Expected a remove button as 1 item added to cart." )
    }
    
    func test_seachInHomeTab() {
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
    
    func test_detailViewFromHomeTab() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        XCTAssert(app.collectionViews.cells.firstMatch.exists)
        app.collectionViews.cells.firstMatch.tap()
        
        XCTAssert(app.scrollViews.element.exists)
        XCTAssertEqual(app.scrollViews.staticTexts.count, 5)
        XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)

        app.navigationBars.firstMatch.buttons["WeShop"].tap()
    }
    
}

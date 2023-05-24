//
//  DiscoverScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class DiscoverScreenUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_discoverTabUIElements() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Discover"].exists)
        tabBar.buttons["Discover"].tap()
        
        XCTAssert(app.navigationBars["WeShop"].exists)
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        XCTAssert(weshopNavigationBar.staticTexts["WeShop"].exists)
        XCTAssert(weshopNavigationBar.buttons["Info"].exists)
        XCTAssert(weshopNavigationBar.searchFields["Search"].exists)
    }
    
    func test_seachInDiscoverTab() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Discover"].exists)
        tabBar.buttons["Discover"].tap()
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        let searchSearchField = weshopNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        
        app.typeText("P")
        
        searchSearchField.buttons["Clear text"].tap()
        weshopNavigationBar.buttons["Cancel"].tap()
        
        XCTAssert(tabBar.buttons["Discover"].isSelected)
    }
    
    func test_detailViewFromDiscoverTab() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Discover"].exists)
        tabBar.buttons["Discover"].tap()
        
        XCTAssert(app.scrollViews.otherElements.buttons.firstMatch.exists)
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        
        XCTAssert(app.scrollViews.element.exists)
        
        XCTAssertEqual(app.scrollViews.staticTexts.count, 5)
        XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)

        app.navigationBars.firstMatch.buttons["WeShop"].tap()
    }
    
}

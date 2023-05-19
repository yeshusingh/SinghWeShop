//
//  CartScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/15/23.
//

import XCTest
@testable import SinghWeShop

final class CartScreenUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
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
        
        //TODO: Checkout functionality not coded yet. Revist test later.
    }
}

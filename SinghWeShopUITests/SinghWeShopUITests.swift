//
//  SinghWeShopUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/14/23.
//

import XCTest
@testable import SinghWeShop

final class SinghWeShopUITests: XCTestCase {
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
        XCTAssertFalse(tabBar.buttons["Info"].exists)
    }
    
    func test_homeTabUIElements() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        XCTAssert(app.navigationBars["WeShop"].exists)
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        XCTAssert(weshopNavigationBar.staticTexts["WeShop"].exists)
        XCTAssert(weshopNavigationBar.buttons["Info"].exists)
        XCTAssert(weshopNavigationBar.searchFields["Search"].exists)
        
        XCTAssertGreaterThanOrEqual(app.collectionViews.cells.count, 5)
        
        //XCUIApplication().tabBars["Tab Bar"].buttons["Home"].tap()
        //let app = XCUIApplication()
        //let weshopNavigationBar = app.navigationBars["WeShop"]
        //weshopNavigationBar.staticTexts["WeShop"].tap()
        //weshopNavigationBar.buttons["Info"].tap()
        //app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["WeShop"].tap()
        //weshopNavigationBar.searchFields["Search"].tap()
        //weshopNavigationBar.buttons["Cancel"].tap()
        //app.collectionViews/*@START_MENU_TOKEN@*/.cells.buttons["Amazon Basics Block White Eraser, Price :, $6.90"]/*[[".cells.buttons[\"Amazon Basics Block White Eraser, Price :, $6.90\"]",".buttons[\"Amazon Basics Block White Eraser, Price :, $6.90\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.swipeUp()
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
        
        //XCTAssertGreaterThanOrEqual(app.collectionViews.cells.count, 5)
        // ???
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
    
    func test_itemDetailUIElements() throws {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")
        
        app.collectionViews.cells.firstMatch.tap()
        
        XCTAssert(app.scrollViews.element.exists)
        let image = app.scrollViews.images.firstMatch
        image.swipeUp()
        
        XCTAssertEqual(app.scrollViews.staticTexts.count, 5)
        
        XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)
        app.scrollViews.buttons["Add to Cart"].tap()

        app.navigationBars.firstMatch.buttons["WeShop"].tap()
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
        //XCTAssert(elementsQuery.staticTexts[Constants.General.appTitle].exists)
        XCTAssert(elementsQuery.staticTexts["This is where you come to do all your shopping."].exists)
        
        XCTAssert(elementsQuery.staticTexts["Browse the items - You can view items on the homepage and click them to get more details."].exists)
        XCTAssert(elementsQuery.staticTexts["Add items to the cart as you continue shopping. And the cart will hold all added items in place for checkout."].exists)
        XCTAssert(elementsQuery.staticTexts["You can apply discount coupons in the cart at the time of checkout."].exists)
        
        app.navigationBars.firstMatch.buttons["WeShop"].tap()
    }
    
    func test_ItemInCart() throws {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()

        try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")

        app.collectionViews.cells.firstMatch.tap()
        let identifierForImage  = app.scrollViews.otherElements.children(matching: .image).element.label

        XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)
        app.scrollViews.buttons["Add to Cart"].tap()
        
        app.navigationBars.firstMatch.buttons["WeShop"].tap()
        XCTAssert(tabBar.buttons["Cart"].exists)
        tabBar.buttons["Cart"].tap()

        let itemRemove = app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"2\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.containing(.image, identifier: identifierForImage)
        itemRemove.children(matching: .button).matching(identifier: "Remove").element(boundBy: 0).tap()
    }
    
    func test_swipeActionToAddToCart() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        let itemToSwipe = app.collectionViews.cells.firstMatch
        itemToSwipe.swipeRight()
        app.collectionViews.buttons["AddToCart"].tap()
    }
    
    func test_checkout() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Cart"].exists)
        
        let cartButton = tabBar.buttons["Cart"]
        cartButton.tap()
        
        XCTAssert(app.scrollViews.otherElements.buttons["Order Now"].exists)
        app.scrollViews.otherElements.buttons["Order Now"].tap()
    }

    func test_seachInHomeTab() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        let searchSearchField = weshopNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        
        let pKey = app/*@START_MENU_TOKEN@*/.keys["P"]/*[[".keyboards.keys[\"P\"]",".keys[\"P\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()
        
        searchSearchField.buttons["Clear text"].tap()
        weshopNavigationBar.buttons["Cancel"].tap()
    }
    
    
    func test_seachInDiscoverTab() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Discover"].exists)
        tabBar.buttons["Discover"].tap()
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        let searchSearchField = weshopNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        
        let pKey = app/*@START_MENU_TOKEN@*/.keys["P"]/*[[".keyboards.keys[\"P\"]",".keys[\"P\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()
        
        searchSearchField.buttons["Clear text"].tap()
        weshopNavigationBar.buttons["Cancel"].tap()
    }
    
    func test_detailViewFromDiscoverTab() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Discover"].exists)
        tabBar.buttons["Discover"].tap()
        
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        
    }
    
    func test_detailViewDiffOrientation() throws {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")

        XCUIDevice.shared.orientation = .landscapeLeft
        
        app.collectionViews.cells.firstMatch.tap()
        XCTAssert(app.scrollViews.buttons["Add to Cart"].exists)
        
        app.navigationBars.firstMatch.buttons["WeShop"].tap()
        XCUIDevice.shared.orientation = .portrait
    }
    
    func test_onboardingViewDiffOrientation() throws {
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        tabBar.buttons["Home"].tap()
        
        XCTAssert(app.navigationBars["WeShop"].exists)
        
        try XCTSkipUnless(app.collectionViews.cells.count > 0, "Minimum 1 item required to test Item Detail View")
        XCUIDevice.shared.orientation = .landscapeLeft
        
        let weshopNavigationBar = app.navigationBars["WeShop"]
        XCTAssert(weshopNavigationBar.buttons["Info"].exists)
        weshopNavigationBar.buttons["Info"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        XCTAssert(elementsQuery.images["IconPicture"].exists)
        //XCTAssert(elementsQuery.staticTexts[Constants.General.appTitle].exists)
        XCTAssert(elementsQuery.staticTexts["This is where you come to do all your shopping."].exists)
        
        XCTAssert(elementsQuery.staticTexts["Browse the items - You can view items on the homepage and click them to get more details."].exists)
        XCTAssert(elementsQuery.staticTexts["Add items to the cart as you continue shopping. And the cart will hold all added items in place for checkout."].exists)
        XCTAssert(elementsQuery.staticTexts["You can apply discount coupons in the cart at the time of checkout."].exists)
        
        app.navigationBars.firstMatch.buttons["WeShop"].tap()
        
        XCUIDevice.shared.orientation = .portrait
    }
    
}

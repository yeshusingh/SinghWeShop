//
//  AccountViewScreenUITests.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 5/22/23.
//

import XCTest

final class AccountViewScreenUITests: XCTestCase {
    var app: XCUIApplication!
    
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
        
        if app.collectionViews.cells.count == 1 {
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Account Info not available.").element.exists)
        } else if app.collectionViews.cells.count == 11 {
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Account Details".uppercased()).element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Member ID").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "User Details".uppercased()).element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Username").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Name").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Email").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Phone").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Shipping Address".uppercased()).element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "Street").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "City").element.exists)
            XCTAssert(app.collectionViews.cells.otherElements.children(matching: .staticText).matching(identifier: "ZipCode").element.exists)
        } else {
            XCTFail("Unverified UI conditon detected.")
        }
    }

}

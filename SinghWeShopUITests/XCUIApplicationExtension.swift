//
//  XCUIApplicationExtension.swift
//  SinghWeShopUITests
//
//  Created by Yeshu Singh on 6/20/23.
//

import XCTest

extension XCUIApplication {
  func loginSetup() {
    self.textFields["Enter UserID"].tap()
    self.typeText("1")
    self.secureTextFields["Enter Password"].tap()
    self.typeText("m38rmF$")

    self.buttons["return"].tap()
    self.buttons["Login"].tap()
  }

  func logoutStep() {
    self.tabBars["Tab Bar"].buttons["Account"].tap()
    self.collectionViews.buttons["Logout"].tap()
  }
}

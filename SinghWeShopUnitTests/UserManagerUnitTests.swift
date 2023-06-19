//
//  UserManagerUnitTests.swift
//  SinghWeShopUnitTests
//
//  Created by Yeshu Singh on 6/18/23.
//

import XCTest
@testable import SinghWeShop

final class UserManagerUnitTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var userStore: UserManager!
  // The setUpWithError/tearDownWithError methods are run for each individual test, hence it better to setup/assign value to the userStore there as it will
  // a fresh start for each test run. Similarly the userStore will be set to nil after each test is completed.

  override func setUpWithError() throws {
    try super.setUpWithError()
    userStore = UserManager()
  }

  override func tearDownWithError() throws {
    userStore = nil
    try super.tearDownWithError()
  }

  func test_loadUserData() async throws {
    XCTAssertNil(userStore.user, "User should have been Nil at intialization.")

    if FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: userStore.userJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()))

    let promise = expectation(description: "Load User Info")

    do {
      try await userStore.loadUser(for: 2)
    } catch let error {
      print(error)
    }
    promise.fulfill()

    await fulfillment(of: [promise], timeout: 5)

    if let user = userStore.user {
      XCTAssertEqual(user.id, 2)
    } else {
      XCTFail("User data is nil. Load User did not succeed.")
    }

    XCTAssertTrue(
      FileManager.default.fileExists(
        atPath: userStore.userJSONURL.absoluteURL.path()),
      "User not saved in json file, Save function did not succeed."
    )
  }

  func test_readUserFromJSONFile() {
    XCTAssertNil(userStore.user, "User should have been Nil at intialization.")

    if FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()) {
      userStore.loadUserFromJSONFile()
      XCTAssertNotNil(userStore.user, "User should have been loaded from JSON file.")
    }
  }

  func test_writeUserToJSONFile() throws {
    if FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: userStore.userJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()))

    userStore.saveUserToJSONFile()

    XCTAssertTrue(
      FileManager.default.fileExists(
        atPath: userStore.userJSONURL.absoluteURL.path()),
      "User data not saved in json file, Save function did not succeed."
    )
  }
}

//
//  MockNetworkManagerUnitTests.swift
//  SinghWeShopUnitTests
//
//  Created by Yeshu Singh on 6/3/23.
//

import XCTest
@testable import SinghWeShop

final class MockNetworkManagerUnitTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var itemStore: ItemsManager!
  // The setUpWithError/tearDownWithError methods are run for each individual test, hence it better to setup/assign value to the itemStore there as it will
  // a fresh start for each test run. Similarly the itemStore will be set to nil after each test is completed.

  // swiftlint:disable:next implicitly_unwrapped_optional
  var userStore: UserManager!
  // The setUpWithError/tearDownWithError methods are run for each individual test, hence it better to setup/assign value to the userStore there as it will
  // a fresh start for each test run. Similarly the userStore will be set to nil after each test is completed.


  override func setUpWithError() throws {
    try super.setUpWithError()
    itemStore = ItemsManager()
    itemStore.service = MockNetworkManager()
    userStore = UserManager()
  }

  override func tearDownWithError() throws {
    itemStore = nil
    userStore = nil
    try super.tearDownWithError()
  }

  func test_mockLoadProductData() async throws {
    XCTAssertEqual(itemStore.allItems.count, 0, "Products should have been Zero at intialization.")

    if FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: itemStore.itemsJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()))

    do {
      try await itemStore.loadItems()
    } catch let error {
      print(error)
    }

    XCTAssertGreaterThan(itemStore.allItems.count, 0, "Products data is Zero. Load Products Data did not succeed.")

    XCTAssertTrue(
      FileManager.default.fileExists(
        atPath: itemStore.itemsJSONURL.absoluteURL.path()),
      "Products data not saved in json file, Save function did not succeed."
    )
  }

  func test_loadUserData() async throws {
    XCTAssertNil(userStore.user, "User should have been Nil at intialization.")

    if FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: userStore.userJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: userStore.userJSONURL.absoluteURL.path()))

    do {
      try await userStore.loadUser(for: 2)
    } catch let error {
      print(error)
    }

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
}

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

  override func setUpWithError() throws {
    try super.setUpWithError()
    itemStore = ItemsManager()
    itemStore.service = MockNetworkManager()
  }

  override func tearDownWithError() throws {
    itemStore = nil
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
    XCTAssertNil(itemStore.user, "User should have been Nil at intialization.")

    if FileManager.default.fileExists(atPath: itemStore.userJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: itemStore.userJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: itemStore.userJSONURL.absoluteURL.path()))

    do {
      try await itemStore.loadUser()
    } catch let error {
      print(error)
    }

    if let user = itemStore.user {
      XCTAssertEqual(user.id, 1)
    } else {
      XCTFail("User data is nil. Load User did not succeed.")
    }

    XCTAssertTrue(
      FileManager.default.fileExists(
        atPath: itemStore.userJSONURL.absoluteURL.path()),
      "User not saved in json file, Save function did not succeed."
    )
  }
}

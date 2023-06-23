//
//  ItemsManagerUnitTests.swift
//  SinghWeShopUnitTests
//
//  Created by Yeshu Singh on 5/21/23.
//

import XCTest
@testable import SinghWeShop

final class ItemsManagerUnitTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var itemStore: ItemsManager!
  // The setUpWithError/tearDownWithError methods are run for each individual test, hence it better to setup/assign value to the itemStore there as it will
  // a fresh start for each test run. Similarly the itemStore will be set to nil after each test is completed.

  override func setUpWithError() throws {
    try super.setUpWithError()
    itemStore = ItemsManager()
  }

  override func tearDownWithError() throws {
    itemStore = nil
    try super.tearDownWithError()
  }

  func test_loadProductData() async throws {
    XCTAssertEqual(itemStore.allItems.count, 0, "Products should have been Zero at intialization.")

    if FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: itemStore.itemsJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()))

    let promise = expectation(description: "Load Products Data")

    do {
      try await itemStore.loadItems()
    } catch let error {
      print(error)
    }
    promise.fulfill()

    await fulfillment(of: [promise], timeout: 5)

    XCTAssertGreaterThan(itemStore.allItems.count, 0, "Products data is Zero. Load Products Data did not succeed.")

    XCTAssertTrue(
      FileManager.default.fileExists(
        atPath: itemStore.itemsJSONURL.absoluteURL.path()),
      "Products data not saved in json file, Save function did not succeed."
    )
  }

  func test_readProductsFromJSONFile() {
    if FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()) {
      itemStore.loadItemsFromJSONFile()
      XCTAssertGreaterThan(itemStore.allItems.count, 0)
    } else {
      XCTAssertEqual(itemStore.allItems.count, 0)
    }
  }

  func test_writeProductsToJSONFile() throws {
    if FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()) {
      try FileManager.default.removeItem(at: itemStore.itemsJSONURL)
    }

    XCTAssertFalse(FileManager.default.fileExists(atPath: itemStore.itemsJSONURL.absoluteURL.path()))

    itemStore.saveItemsToJSONFile()

    XCTAssertTrue(
      FileManager.default.fileExists(
        atPath: itemStore.itemsJSONURL.absoluteURL.path()),
      "Products data not saved in json file, Save function did not succeed."
    )
  }
}

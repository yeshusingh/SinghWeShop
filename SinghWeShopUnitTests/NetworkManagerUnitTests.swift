//
//  NetworkManagerUnitTests.swift
//  SinghWeShopUnitTests
//
//  Created by Yeshu Singh on 5/21/23.
//

import XCTest
@testable import SinghWeShop

final class NetworkManagerUnitTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var networkManager: NetworkManager!

  override func setUpWithError() throws {
    try super.setUpWithError()
    networkManager = NetworkManager()
  }

  override func tearDownWithError() throws {
    networkManager = nil
    try super.tearDownWithError()
  }

  func test_fetchProductsData() async {
    var products: [Item]?
    let promise = expectation(description: "Fetch upto 10 products")

    do {
      products = try await networkManager.fetchProductsData(upto: 10)
    } catch let error {
      print(error)
    }
    promise.fulfill()

    await fulfillment(of: [promise], timeout: 5)

    if let products = products {
      XCTAssertLessThanOrEqual(products.count, 10, "Fetched product count mismatch.")
    } else {
      XCTFail("Products array is nil. Fetch products did not succeed.")
    }
  }

  func test_fetchUserData() async {
    var user: User?
    let promise = expectation(description: "Fetch User Info")

    do {
      user = try await networkManager.fetchUserInfo(for: 2)
    } catch let error {
      print(error)
    }
    promise.fulfill()

    await fulfillment(of: [promise], timeout: 5)

    if let user = user {
      XCTAssertEqual(user.id, 2)
    } else {
      XCTFail("User data is nil. Fetch User did not succeed.")
    }
  }
}

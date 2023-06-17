//
//  CartManagerUnitTests.swift
//  CartManagerUnitTests
//
//  Created by Yeshu Singh on 5/14/23.
//

import XCTest
@testable import SinghWeShop

final class CartManagerUnitTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var cartStore: CartManager!

  override func setUpWithError() throws {
    cartStore = CartManager()
  }

  override func tearDownWithError() throws {
    cartStore = nil
  }

  func test_AddToCart() {
    XCTAssertEqual(cartStore.cartItems.count, 0)

    cartStore.addToCart(ItemSampleData.boatNeckT)
    XCTAssertEqual(cartStore.cartItems.count, 1)

    cartStore.addToCart(ItemSampleData.rainJacket)
    XCTAssertEqual(cartStore.cartItems.count, 2)
  }

  func test_RemoveFromCart() {
    // Removing item with 0 item in Cart, code should handle the scenario
    cartStore.removeFromCart(ItemSampleData.boatNeckT)
    XCTAssertEqual(cartStore.cartItems.count, 0)

    // Add 2 items to cart and then verify count, Remove items and verify count again
    cartStore.addToCart(ItemSampleData.boatNeckT)
    cartStore.addToCart(ItemSampleData.rainJacket)
    XCTAssertEqual(cartStore.cartItems.count, 2)

    if let firstItem = cartStore.cartItems.first {
      cartStore.removeFromCart(firstItem)
      XCTAssertEqual(cartStore.cartItems.count, 1)
    }

    if let lastItem = cartStore.cartItems.last {
      cartStore.removeFromCart(lastItem)
      XCTAssertEqual(cartStore.cartItems.count, 0)
    }
  }

  func test_currentDiscountApplied() {
    XCTAssertEqual(cartStore.totalCartItemsAmount, 0)

    let amount = cartStore.calculateAmountAfterDiscount(ItemSampleData.boatNeckT)

    cartStore.addToCart(ItemSampleData.boatNeckT)
    XCTAssertEqual(cartStore.totalCartItemsAmount, amount)
  }

  func test_findTotalCartItemsAmount() {
    XCTAssertEqual(cartStore.totalCartItemsAmount, 0)

    cartStore.addToCart(ItemSampleData.boatNeckT)
    cartStore.addToCart(ItemSampleData.rainJacket)

    let amount = cartStore.cartItems[0].discountedPrice + cartStore.cartItems[1].discountedPrice
    XCTAssertEqual(cartStore.totalCartItemsAmount, amount)
  }
}

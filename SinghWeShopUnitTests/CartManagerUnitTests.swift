//
//  CartManagerUnitTests.swift
//  CartManagerUnitTests
//
//  Created by Yeshu Singh on 5/14/23.
//

import XCTest
@testable import SinghWeShop

final class CartManagerUnitTests: XCTestCase {
    var cartStore: CartManager!
    
    override func setUpWithError() throws {
        cartStore = CartManager()
    }
    
    override func tearDownWithError() throws {
        cartStore = nil
    }
    
    func test_AddToCart() {
        XCTAssertEqual(cartStore.cartItems.count, 0)
        
        cartStore.addToCart(ItemSampleData.appleWatch)
        XCTAssertEqual(cartStore.cartItems.count, 1)
        
        cartStore.addToCart(ItemSampleData.eraser)
        XCTAssertEqual(cartStore.cartItems.count, 2)
    }
    
    func test_RemoveFromCart() {
        // Removing item with 0 item in Cart
        cartStore.removeFromCart(ItemSampleData.appleWatch)
        XCTAssertEqual(cartStore.cartItems.count, 0)
        
        // Add 2 items to cart and then verify count, Remove items and verify count again
        cartStore.addToCart(ItemSampleData.appleWatch)
        cartStore.addToCart(ItemSampleData.eraser)
        XCTAssertEqual(cartStore.cartItems.count, 2)
        
        cartStore.removeFromCart(cartStore.cartItems.first!)
        XCTAssertEqual(cartStore.cartItems.count, 1)
        
        cartStore.removeFromCart(cartStore.cartItems.last!)
        XCTAssertEqual(cartStore.cartItems.count, 0)
    }
    
    func test_setDiscountType() {
        XCTAssertEqual(cartStore.currentDiscountType, DiscountType.defaultDiscount)
        cartStore.setDiscountType(type: .blackFriday)
        XCTAssertEqual(cartStore.currentDiscountType, DiscountType.blackFriday)
    }
    
    func test_findTotalCartItemsAmount() {
        XCTAssertEqual(cartStore.totalCartItemsAmount, 0)
        
        cartStore.addToCart(ItemSampleData.appleWatch)
        cartStore.addToCart(ItemSampleData.eraser)
        
        let amount = cartStore.cartItems[0].discountedPrice + cartStore.cartItems[1].discountedPrice
        XCTAssertEqual(cartStore.totalCartItemsAmount, amount)
    }
    
}

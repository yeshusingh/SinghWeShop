//
//  CartManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var cartItems: [Item] = []
    
    private var currentDiscountType = DiscountType.defaultDiscount
    
    var totalCartItemsAmount: Double {
        cartItems.reduce(0) { $0 + $1.discountedPrice }
    }
    
    init() {
        addToCart(ItemSampleData.notepad)
        addToCart(ItemSampleData.pencil)
        addToCart(ItemSampleData.eraser)
    }
    
    func setDiscountType(type: DiscountType) {
        self.currentDiscountType = type
    }
    
    func addToCart(_ item: Item) {
        var tempItem = item
        tempItem.discountedPrice = calculateAmountAfterDiscount(tempItem)
        cartItems.append(tempItem)
    }
    
    private func calculateAmountAfterDiscount(_ item: Item) -> Double {
        let discountPercentage = currentDiscountType.rawValue
        let discount = item.price * (discountPercentage / 100)
        return item.price - discount
    }
}

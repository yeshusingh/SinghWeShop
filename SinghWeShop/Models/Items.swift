//
//  Items.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/16/23.
//

import Foundation

enum DiscountType: Double, CaseIterable {
    case defaultDiscount = 5.0
    case nationalDay = 10.0
    case blackFriday = 15.0
    case newYear = 20.0
}

struct Items {
    var allItems: [Item] = []
    private(set) var cartItems: [Item] = []
    
    private var currentDiscountType = DiscountType.defaultDiscount
    
    var totalCartItemsAmount: Double {
        cartItems.reduce(0) { $0 + $1.discountedPrice }
    }
    
    init() {
        allItems.append(ItemSampleData.notepad)
        allItems.append(ItemSampleData.pencil)
        allItems.append(ItemSampleData.eraser)
        allItems.append(ItemSampleData.glueStick)
        allItems.append(ItemSampleData.sharpener)
        allItems.append(ItemSampleData.paper)
        
        addToCart(ItemSampleData.notepad)
        addToCart(ItemSampleData.pencil)
        addToCart(ItemSampleData.eraser)
    }
    
    func showItem() -> [Item] {
        var withURL = [Item]()
        
        for item in allItems {
            if let _ = item.imageURL {
                withURL.append(item)
            }
        }
        
        return withURL
    }
    
    mutating func setDiscountType(type: DiscountType) {
        self.currentDiscountType = type
    }
    
    mutating func addToCart(_ item: Item) {
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





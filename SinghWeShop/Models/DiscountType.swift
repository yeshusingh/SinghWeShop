//
//  DiscountType.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import Foundation

enum DiscountType: Double, CaseIterable {
    case defaultDiscount = 5.0
    case nationalDay = 10.0
    case blackFriday = 15.0
    case newYear = 20.0
}

enum ItemCategories {
    case stationary
    case electronics
    case clothes
}


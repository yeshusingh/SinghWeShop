//
//  CartManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import Foundation

class CartManager: ObservableObject {
  @Published private(set) var cartItems: [Item] = [] {
    didSet {
      saveCartToJSONFile()
    }
  }

  let cartJSONURL = URL(filePath: "cart", relativeTo: .documentsDirectory).appendingPathExtension("json")

  var currentDiscountType: DiscountType {
    let calendar = Calendar.current
    let month = calendar.component(.month, from: Date.now)

    switch month {
    case 7:
      return DiscountType.independenceDay
    case 11:
      return DiscountType.blackFriday
    case 12:
      return DiscountType.newYear
    default:
      return DiscountType.defaultDiscount
    }
  }

  var totalCartItemsAmount: Double {
    cartItems.reduce(0) { $0 + $1.discountedPrice }
  }

  func calculateAmountAfterDiscount(_ item: Item) -> Double {
    let discountPercentage = currentDiscountType.rawValue
    let discount = item.price * (discountPercentage / 100)
    return item.price - discount
  }

  func addToCart(_ item: Item) {
    var tempItem = item
    tempItem.discountedPrice = calculateAmountAfterDiscount(tempItem)
    cartItems.append(tempItem)
  }

  func removeFromCart(_ item: Item) {
    guard !cartItems.isEmpty else { return }

    if let index = cartItems.firstIndex(of: item) {
      cartItems.remove(at: index)
    }
  }

  func clearCart() {
    guard !cartItems.isEmpty else { return }
    cartItems.removeAll()
  }

  func saveCartToJSONFile () {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let data = try encoder.encode(cartItems)
      try data.write(to: cartJSONURL, options: .atomic)
    } catch let EncodingError.invalidValue(value, context) {
      print("Invalid Value '\(value)':", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print("error: ", error)
    }
  }

  func loadCartFromJSONFile() {
    let decoder = JSONDecoder()

    guard FileManager.default.fileExists(atPath: cartJSONURL.absoluteURL.path()) else { return }

    do {
      let cartData = try Data(contentsOf: cartJSONURL)
      cartItems = try decoder.decode([Item].self, from: cartData)
    } catch let DecodingError.dataCorrupted(context) {
      print(context)
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.typeMismatch(type, context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print("error: ", error)
    }
  }

  func removeCartJSONFile() {
    if FileManager.default.fileExists(atPath: cartJSONURL.absoluteURL.path()) {
      do {
        try FileManager.default.removeItem(at: cartJSONURL)
      } catch {
        print("error: ", error)
      }
    }
  }
}

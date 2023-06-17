//
//  MockNetworkManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/16/23.
//

import Foundation

struct MockNetworkManager: NetworkSession {
  let decoder = JSONDecoder()

  func fetchProductsData(upto limit: Int) async throws -> [Item]? {
    var products: [Item]?

    if let localURL = Bundle.main.url(forResource: "items", withExtension: "json") {
      do {
        let productsData = try Data(contentsOf: localURL)
        products = try decoder.decode([Item].self, from: productsData)
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

    if let products = products {
      let range = min(products.count, limit)
      let result = Array(products[..<range])
      return result
    }

    return products
  }

  func fetchUserInfo(for id: Int) async throws -> User? {
    var user: User?

    if let localURL = Bundle.main.url(forResource: "user", withExtension: "json") {
      do {
        let userData = try Data(contentsOf: localURL)
        user = try decoder.decode(User.self, from: userData)
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

    if user?.id == id {
      return user
    } else {
      return nil
    }
  }
}

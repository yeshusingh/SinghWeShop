//
//  ItemsManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import Foundation

class ItemsManager: ObservableObject {
  @Published private(set) var allItems: [Item] = [] {
    didSet {
      saveItemsToJSONFile()
    }
  }

  @Published private(set) var user: User? {
    didSet {
      saveUserToJSONFile()
    }
  }

  var service: NetworkSession = NetworkManager()
  let maxLimit: Int

  var discoverItems: [Item] {
    return allItems.filter {_ in
      Bool.random()
    }
  }

  let itemsJSONURL = URL(filePath: "items", relativeTo: .documentsDirectory).appendingPathExtension("json")
  let userJSONURL = URL(filePath: "user", relativeTo: .documentsDirectory).appendingPathExtension("json")

  init(_ maxLimit: Int = 20) {
    self.maxLimit = maxLimit
  }

  func loadUser() async throws {
    if let userInfo = try? await service.fetchUserInfo(for: 1) {
      await MainActor.run {
        user = userInfo
      }
    } else {
      await MainActor.run {
        loadUserFromJSONFile()
      }
    }
  }

  func saveUserToJSONFile() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let userData = try encoder.encode(user)
      try userData.write(to: userJSONURL, options: .atomic)
    } catch let EncodingError.invalidValue(value, context) {
      print("Invalid Value '\(value)':", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print("error: ", error)
    }
  }

  func loadUserFromJSONFile() {
    let decoder = JSONDecoder()

    if FileManager.default.fileExists(atPath: userJSONURL.absoluteURL.path()) {
      do {
        let userData = try Data(contentsOf: userJSONURL)
        user = try decoder.decode(User.self, from: userData)
        // TODO: Add check to match the user ID ???
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
  }

  func loadItems() async throws {
    if let products = try? await service.fetchProductsData(upto: maxLimit) {
      await MainActor.run {
        allItems = products
      }
    } else {
      await MainActor.run {
        loadItemsFromJSONFile()
      }
    }
  }

  func saveItemsToJSONFile() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let itemsData = try encoder.encode(allItems)
      try itemsData.write(to: itemsJSONURL, options: .atomic)
    } catch let EncodingError.invalidValue(value, context) {
      print("Invalid Value '\(value)':", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print("error: ", error)
    }

    print("Documents Directory: ", itemsJSONURL.absoluteURL.path())
  }

  func loadItemsFromJSONFile() {
    let decoder = JSONDecoder()

    guard FileManager.default.fileExists(atPath: itemsJSONURL.absoluteURL.path()) else { return }

    do {
      let itemsData = try Data(contentsOf: itemsJSONURL)
      allItems = try decoder.decode([Item].self, from: itemsData)
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
}

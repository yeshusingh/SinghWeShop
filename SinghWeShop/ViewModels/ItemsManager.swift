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

  var service: NetworkSession = NetworkManager()
  let maxLimit: Int

  var discoverItems: [Item] {
    return allItems.filter {_ in
      Bool.random()
    }
  }

  let itemsJSONURL = URL(filePath: "items", relativeTo: .documentsDirectory).appendingPathExtension("json")

  init(_ maxLimit: Int = 20) {
    self.maxLimit = maxLimit
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

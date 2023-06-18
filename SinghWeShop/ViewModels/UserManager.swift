//
//  UserManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/16/23.
//

import Foundation

class UserManager: ObservableObject {
  @Published private(set) var user: User? {
    didSet {
      saveUserToJSONFile()
    }
  }

  @Published var loginState = false

  let userJSONURL = URL(filePath: "user", relativeTo: .documentsDirectory).appendingPathExtension("json")
  let service: NetworkSession = NetworkManager()

  func loadUser(for id: Int) async throws {
    if let userInfo = try? await service.fetchUserInfo(for: id) {
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

  func removeUserJSONFile() {
    if FileManager.default.fileExists(atPath: userJSONURL.absoluteURL.path()) {
      do {
        try FileManager.default.removeItem(at: userJSONURL)
      } catch {
        print("error: ", error)
      }
    }
  }
}

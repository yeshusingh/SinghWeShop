//
//  NetworkManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/19/23.
//

import Foundation

protocol NetworkSession {
  func fetchProductsData(upto limit: Int) async throws -> [Item]?
  func fetchUserInfo(for id: Int) async throws -> User?
}

enum NetworkError: String, Error {
  case unableToProcess = "Unable to process login request."
  case encodingForLogin = "Failed to process encoding for login request."
  case serverBadResponse = "Server responded with errror."
  case loginFailed = "Login failed."
}

struct NetworkManager: NetworkSession {
  let baseURLString = "https://fakestoreapi.com"
  let session = URLSession.shared
  let decoder = JSONDecoder()

  func fetchProductsData(upto limit: Int) async throws -> [Item]? {
    var products: [Item]?
    let productURLString = baseURLString + "/products"

    guard var productURLComponents = URLComponents(string: productURLString) else {
      return nil
    }
    productURLComponents.queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]

    guard let queryURL = productURLComponents.url else {
      return nil
    }
    let request = URLRequest(url: queryURL)

    let (data, response) = try await session.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
      handleHTTPError(response)
      return nil
    }

    do {
      products = try decoder.decode([Item].self, from: data)
    } catch let DecodingError.dataCorrupted(context) {
      print(context)
      return nil
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
    } catch let DecodingError.typeMismatch(type, context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
    } catch {
      print("error: ", error)
      return nil
    }

    return products
  }

  func fetchUserInfo(for id: Int) async throws -> User? {
    var user: User?
    let userURLString = baseURLString + "/users/\(id)"

    guard let userURLComponents = URLComponents(string: userURLString) else {
      return nil
    }

    guard let queryURL = userURLComponents.url else {
      return nil
    }

    let request = URLRequest(url: queryURL)

    let (data, response) = try await session.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
      handleHTTPError(response)
      return nil
    }

    do {
      user = try decoder.decode(User.self, from: data)
    } catch let DecodingError.dataCorrupted(context) {
      print(context)
      return nil
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
    } catch let DecodingError.typeMismatch(type, context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
    } catch {
      print("error: ", error)
      return nil
    }

    return user
  }

  func performLoginFor(user: String, password: String) async throws {
    let loginURLString = baseURLString + "/auth/login"

    guard let loginURLComponents = URLComponents(string: loginURLString) else {
      throw NetworkError.unableToProcess
    }
    guard let queryURL = loginURLComponents.url else {
      throw NetworkError.unableToProcess
    }

    let bodyDictionary = ["username": user, "password": password]
    guard let encoded = try? JSONEncoder().encode(bodyDictionary) else {
      throw NetworkError.encodingForLogin
    }

    var request = URLRequest(url: queryURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = encoded

    do {
      let (data, response) = try await session.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
        handleHTTPError(response)
        throw NetworkError.serverBadResponse
      }
      print("Response data: ", String(data: data, encoding: .utf8) ?? "")
    } catch {
      print("Login failed - \(error.localizedDescription)")
      throw NetworkError.loginFailed
    }
  }

  func handleHTTPError(_ response: URLResponse) {
    if let httpResponse = response as? HTTPURLResponse {
      switch httpResponse.statusCode {
      case 100..<200:
        print("Informational Response: \(httpResponse.statusCode)")
      case 300..<400:
        print("Redirection Response: \(httpResponse.statusCode)")
      case 400..<500:
        print("Client Error Response: \(httpResponse.statusCode)")
      case 500..<600:
        print("Server Error Response: \(httpResponse.statusCode)")
      default:
        print("Error Response: \(httpResponse.statusCode)")
      }
    } else {
      print("Bad Server response : Could not parse as HTTPURLResponse")
    }
  }
}

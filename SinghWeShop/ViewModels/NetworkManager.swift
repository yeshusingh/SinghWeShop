//
//  NetworkManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/19/23.
//

import Foundation

// Week 9: Assignment 4
protocol NetworkSession {
  func fetchProductsData(upto limit: Int) async throws -> [Item]?
  func fetchUserInfo(for id: Int) async throws -> User?
}

struct NetworkManager: NetworkSession {
  let baseURLString = "https://fakestoreapi.com"
  let session = URLSession.shared
  let decoder = JSONDecoder()

  // Week 9: Assignment 1
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

    // Week 9: Assignment 2
    let (data, response) = try await session.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
      handleHTTPError(response)
      return nil
    }

    // Week 9: Assignment 2
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

  // Week 9: Assignment 1
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

    // Week 9: Assignment 2
    let (data, response) = try await session.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
      handleHTTPError(response)
      return nil
    }

    // Week 9: Assignment 2
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

  // Week 9: Assignment 2
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

// Week 9: Assignment 4
struct MockNetworkManager: NetworkSession {
  let decoder = JSONDecoder()

  func fetchProductsData(upto limit: Int) async throws -> [Item]? {
    var products: [Item]?

    // Week 9: Assignment 2
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

    // Week 9: Assignment 2
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

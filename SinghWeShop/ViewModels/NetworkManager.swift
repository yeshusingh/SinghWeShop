//
//  NetworkManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/19/23.
//

import Foundation

struct NetworkManager {
  let baseURLString = "https://fakestoreapi.com"
  let session = URLSession.shared
  let decoder = JSONDecoder()
  let encoder = JSONEncoder()

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
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      print("Error in fetch products")
      return nil
    }

    do {
      products = try decoder.decode([Item].self, from: data)
    } catch {
      print(error)
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
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      print("Error in fetch user")
      return nil
    }

    do {
      user = try decoder.decode(User.self, from: data)
    } catch {
      print(error)
      return nil
    }

    return user
  }
}

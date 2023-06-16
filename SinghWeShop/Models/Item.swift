//
//  Item.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/16/23.
//

import Foundation

struct Item: Hashable, Identifiable, Codable {
  enum CodingKeys: String, CodingKey {
    case id, price, category, description
    case name = "title"
    case imageURL = "image"
  }

  let id: Int
  var name: String
  var price: Double
  var discountedPrice: Double
  var category: String
  var description: String
  var imageURL: String
}

extension Item {
  init(id: Int, name: String, price: Double, description: String, category: String, imageURL: String) {
    self.id = id
    self.name = name
    self.price = price
    self.discountedPrice = price
    self.description = description
    self.category = category
    self.imageURL = imageURL
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    price = try container.decode(Double.self, forKey: .price)
    discountedPrice = price
    category = try container.decode(String.self, forKey: .category)
    description = try container.decode(String.self, forKey: .description)
    imageURL = try container.decode(String.self, forKey: .imageURL)
  }
}

enum ItemSampleData {
  public static let womenTshirt = Item(
    id: 20,
    name: "DANVOUY Womens T Shirt Casual Cotton Short",
    price: 12.99,
    discountedPrice: 12.99,
    category: "women's clothing",
    description: """
      95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, \
      The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. \
      Season: Spring,Summer,Autumn,Winter.
      """,
    imageURL: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg"
  )

  public static let shortSleeve = Item(
    id: 19,
    name: "Opna Women's Short Sleeve Moisture",
    price: 7.9500000000000002,
    discountedPrice: 7.9500000000000002,
    category: "women's clothing",
    description: """
      100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & \
      Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking \
      fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck \
      collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort
      """,
    imageURL: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg"
  )

  public static let boatNeckT = Item(
    id: 18,
    name: "MBJ Women's Solid Short Sleeve Boat Neck V ",
    price: 9.8499999999999996,
    discountedPrice: 9.8499999999999996,
    category: "women's clothing",
    description: """
    95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great \
    stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem
    """,
    imageURL: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg"
  )

  public static let rainJacket = Item(
    id: 17,
    name: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
    price: 39.990000000000002,
    discountedPrice: 39.990000000000002,
    category: "women's clothing",
    description: """
      Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. \
      Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good \
      size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached \
      Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.
      """,
    imageURL: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg"
  )
}

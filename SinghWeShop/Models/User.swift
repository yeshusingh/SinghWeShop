//
//  User.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/20/23.
//

import Foundation

struct User: Identifiable, Codable {
  let id: Int
  let email: String
  let username: String
  let password: String
  let name: Name
  let address: Address
  let phone: String
}

struct Name: Codable {
  let firstname: String
  let lastname: String
}

struct Address: Codable {
  let city: String
  let street: String
  let number: Int
  let zipcode: String
  let geolocation: Geolocation
}

struct Geolocation: Codable {
  let lat: String
  let long: String
}

enum SampleUserInfo {
  public static let user = User(
    id: 1,
    email: "john@gmail.com",
    username: "johnd",
    password: "m38rmF$",
    name: Name(firstname: "john", lastname: "doe"),
    address: Address(
      city: "kilcoole",
      street: "new road",
      number: 7682,
      zipcode: "12926-3874",
      geolocation: Geolocation(lat: "-37.3159", long: "81.1496")),
    phone: "1-570-236-7033")
}

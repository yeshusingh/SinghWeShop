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
    let city : String
    let street: String
    let number: Int
    let zipcode: String
    let geolocation: Geolocation
}

struct Geolocation: Codable {
    let lat: String
    let long: String
}

struct SampleUserInfo {
    public static var user: User? {
        let localURL = Bundle.main.url(forResource: "user", withExtension: "json")!
        
        do {
            let userData = try Data(contentsOf: localURL)
            let user = try JSONDecoder().decode(User.self, from: userData)
            return user
        } catch let error {
            print(error)
        }
        
        return nil
    }
}

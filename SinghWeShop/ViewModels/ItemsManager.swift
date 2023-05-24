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
            saveItemsToPlistFile()
            saveItemsToFile()
        }
    }
    
    @Published private(set) var user: User? {
        didSet {
            saveUserToJSONFile()
        }
    }
    
    let service = NetworkManager()
    let maxLimit: Int
    
    var discoverItems:  [Item] {
        return allItems.filter{_ in
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
        } catch let error {
            print(error)
        }
    }
    
    func loadUserFromJSONFile() {
        let decoder = JSONDecoder()
        
        if FileManager.default.fileExists(atPath: userJSONURL.absoluteURL.path()) {
            do {
                let userData = try Data(contentsOf: userJSONURL)
                user = try decoder.decode(User.self, from: userData)
            } catch let error {
                print(error)
            }
        } else {
            if let localURL = Bundle.main.url(forResource: "user", withExtension: "json") {
                do {
                    let userData = try Data(contentsOf: localURL)
                    user = try decoder.decode(User.self, from: userData)
                } catch let error {
                    print(error)
                }
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
        } catch let error {
            print(error)
        }
        
        print("Documents Directory: ", itemsJSONURL.absoluteURL.path())
    }
    

    func loadItemsFromJSONFile() {
        let decoder = JSONDecoder()
        
        guard FileManager.default.fileExists(atPath: itemsJSONURL.absoluteURL.path()) else { return }
        
        do {
            let itemsData = try Data(contentsOf: itemsJSONURL)
            allItems = try decoder.decode([Item].self, from: itemsData)
        } catch let error {
            print(error)
        }
    }
    
    func saveItemsToPlistFile() {
        let itemsPlistURL = URL(filePath: "items", relativeTo: .documentsDirectory).appendingPathExtension("plist")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let itemsData = try encoder.encode(allItems)
            try itemsData.write(to: itemsPlistURL, options: .atomic)
        } catch let error {
            print(error)
        }
    }
    
    func loadItemsFromPlistFile() -> [Item] {
        let itemsPlistURL = URL(filePath: "items", relativeTo: .documentsDirectory).appendingPathExtension("plist")
        let decoder = PropertyListDecoder()
        var itemsFromPlistFile: [Item] = []
        
        guard FileManager.default.fileExists(atPath: itemsPlistURL.absoluteURL.path()) else { return itemsFromPlistFile }
        
        do {
            let itemsData = try Data(contentsOf: itemsPlistURL)
            itemsFromPlistFile = try decoder.decode([Item].self, from: itemsData)
        } catch let error {
            print(error)
        }
        
        return itemsFromPlistFile
    }
    
    func saveItemsToFile() {
        let itemsFileURL = URL(filePath: "items", relativeTo: .documentsDirectory)
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        
        do {
            let itemsData = try encoder.encode(allItems)
            try itemsData.write(to: itemsFileURL, options: .atomic)
        } catch let error {
            print(error)
        }
    }

    func loadItemsFromFile() -> [Item] {
        let itemsFileURL = URL(filePath: "items", relativeTo: .documentsDirectory)
        let decoder = PropertyListDecoder()
        var itemsFromFile: [Item] = []
        
        guard FileManager.default.fileExists(atPath: itemsFileURL.absoluteURL.path()) else { return itemsFromFile }
        
        do {
            let itemsData = try Data(contentsOf: itemsFileURL)
            itemsFromFile = try decoder.decode([Item].self, from: itemsData)
        } catch let error {
            print(error)
        }
        
        return itemsFromFile
    }
}

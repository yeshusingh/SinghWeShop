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
    
    let service = NetworkManager()
    let maxLimit: Int
    
    var discoverItems:  [Item] {
        return allItems.filter{_ in
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
    
//    private func loadDefaultItems() {
//        allItems.append(ItemSampleData.notepad)
//        allItems.append(ItemSampleData.pencil)
//        allItems.append(ItemSampleData.eraser)
//        allItems.append(ItemSampleData.glueStick)
//        allItems.append(ItemSampleData.sharpener)
//        allItems.append(ItemSampleData.paper)
//        allItems.append(ItemSampleData.iPad)
//        allItems.append(ItemSampleData.appleWatch)
//        allItems.append(ItemSampleData.monitor)
//        allItems.append(ItemSampleData.tShirt)
//        allItems.append(ItemSampleData.jeans)
//        allItems.append(ItemSampleData.jacket)
//    }
    
    func saveItemsToJSONFile() {
        //print(#function)
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
        //print(#function)
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
        //print(#function)
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
        //print(#function)
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
        //print(#function)
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
        //print(#function)
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

//
//  ItemsManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import Foundation

class ItemsManager: ObservableObject {
    @Published private(set) var allItems: [Item] = []
    
    var discoverItems:  [Item] {
        return allItems.filter{_ in
            Bool.random()
        }
    }
    
    init() {
        allItems.append(ItemSampleData.notepad)
        allItems.append(ItemSampleData.pencil)
        allItems.append(ItemSampleData.eraser)
//        allItems.append(ItemSampleData.glueStick)
//        allItems.append(ItemSampleData.sharpener)
        allItems.append(ItemSampleData.paper)
//        allItems.append(ItemSampleData.iPad)
        allItems.append(ItemSampleData.appleWatch)
//        allItems.append(ItemSampleData.monitor)
//        allItems.append(ItemSampleData.tShirt)
//        allItems.append(ItemSampleData.jeans)
//        allItems.append(ItemSampleData.jacket)
    }
    
    //TODO:  Add networking code here to fetch data from API into allItems Array
    
}

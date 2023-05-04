//
//  ItemsManager.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import Foundation

class ItemsManager: ObservableObject {
    @Published private(set) var allItems: [Item] = []
    
    init() {
        allItems.append(ItemSampleData.notepad)
        allItems.append(ItemSampleData.pencil)
        allItems.append(ItemSampleData.eraser)
        allItems.append(ItemSampleData.glueStick)
        allItems.append(ItemSampleData.sharpener)
        allItems.append(ItemSampleData.paper)
    }
 
    // TODO :  Add networking code here to fetch data from API into allItems Array
    
}

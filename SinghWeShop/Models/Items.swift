//
//  Items.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/16/23.
//

import Foundation


struct Items {
    var data: [Item] = []
    
    init() {
        data.append(ItemSampleData.notepad)
        data.append(ItemSampleData.pencil)
        data.append(ItemSampleData.eraser)
        data.append(ItemSampleData.glueStick)
        data.append(ItemSampleData.sharpener)
        data.append(ItemSampleData.paper)
    }
    
    func showItem() -> [Item] {
        var withURL = [Item]()
        
        for item in data {
            if let _ = item.imageURL {
                withURL.append(item)
            }
        }
        
        return withURL
    }
}

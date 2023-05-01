//
//  ItemListView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import SwiftUI

struct ItemListView: View {
    var items: [Item]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [.init(.adaptive(minimum: 150))]) {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        ItemView(item: item)
                    }
                }
            }
            .navigationDestination(for: Item.self) { item in
                ItemDetailView(item: item)
            }
        }
        .ignoresSafeArea()
        .padding()
        .background(Color(Constants.Assets.listBackgroundColor))
        .navigationTitle("WeShop")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(items: ItemsManager().allItems)
    }
}


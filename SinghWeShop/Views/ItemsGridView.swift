//
//  ItemsGridView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ItemsGridView: View {
    @State private var searchName = ""
    var items: [Item]
    
    var matchedItems: [Item] {
        if !searchName.isEmpty {
            return items.filter { $0.name.lowercased().contains(searchName.lowercased())}
        } else {
            return items
        }
    }
    
    var matchingItemNames : [String] {
        matchedItems.map{ $0.name }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [.init(.adaptive(minimum: 150))]) {
                    ForEach(matchedItems) { item in
                        NavigationLink(value: item) {
                            GridItem(item: item)
                        }
                    }
                }
                .navigationDestination(for: Item.self) { item in
                    ItemDetailView(item: item)
                }
                .padding(10)
            }
            .searchable(text: $searchName, placement: .navigationBarDrawer(displayMode: .always)) {
                ForEach(matchingItemNames, id: \.self) { name in
                    Text(name).searchCompletion(name)
                }
            }
            .navigationTitle(Constants.General.appTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        OnboardingView()
                    } label: {
                        Image(systemName: Constants.ImageLiteral.infoCircle)
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ItemsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsGridView(items: ItemsManager().allItems)
    }
}
#endif

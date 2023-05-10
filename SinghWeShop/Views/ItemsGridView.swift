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
    
    //Homework Week05 : Assignment 5 - For making List/Grid searchable
    var matchedItems: [Item] {
        if !searchName.isEmpty {
            return items.filter { $0.name.lowercased().contains(searchName.lowercased())}
        } else {
            return items
        }
    }
    
    //Homework Week05 : Assignment 5 - For making List/Grid searchable
    var matchingItemNames : [String] {
        matchedItems.map{ $0.name }
    }
    
    var body: some View {
        //Homework Week05 : Assignment 3 Grid - A scrollable Grid created here. Inside NavigationStack hence allows to tap and view the DetailView screen too. Each grid item view is a combination of Image and Text.
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
            //Homework Week05 : Assignment 5 - Making List/Grid searchable with suggestions shown to user.The search is based on Item name.
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

struct ItemsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsGridView(items: ItemsManager().allItems)
    }
}

//
//  ItemsListView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ItemsListView: View {
    @EnvironmentObject var cartStore: CartManager
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
        //Homework Week05 : Assignment 2 - Summary screen and detail screen done here using List-ForEach combination inside a NavigationStack. Tapping a list cell takes to the detailView Screen.
        NavigationStack {
            List {
                ForEach(matchedItems) { item in
                    NavigationLink(value: item) {
                        ListItem(item: item)
                    }
                    //Homework Week05 : Assignment 5 - Adding Swipe action "AddToCart" to list.
                    .swipeActions(edge: .leading, content: {
                        Button {
                            cartStore.addToCart(item)
                        } label: {
                            Image(systemName: "highlighter")
                            Text("AddToCart")
                        }
                        .tint(.yellow)
                    })
                }
            }
            .listStyle(PlainListStyle())
            .navigationDestination(for: Item.self) { item in
                ItemDetailView(item: item)
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

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView(items: ItemsManager().allItems)
            .environmentObject(CartManager())
    }
}

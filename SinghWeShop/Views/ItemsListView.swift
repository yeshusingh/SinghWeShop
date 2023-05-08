//
//  ItemsListView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ItemsListView: View {
    @EnvironmentObject var cartStore: CartManager
    var items: [Item]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        ListItem(item: item)
                    }
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

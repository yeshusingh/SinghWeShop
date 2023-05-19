//
//  ContentView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//
// Week 07 work

import SwiftUI

struct ContentView: View {
    @StateObject private var itemStore = ItemsManager()
    @StateObject private var cartStore = CartManager()
    
    @AppStorage("CurrentTabSelection") var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ItemsListView(items: itemStore.allItems)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)

            ItemsGridView(items: itemStore.discoverItems)
                .tabItem {
                    Image(systemName: "bolt.square")
                    Text("Discover")
                }
                .tag(1)

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(2)
                .badge(cartStore.cartItems.count)
        }
        .foregroundColor(Color(Constants.Assets.textColor))
        .environmentObject(cartStore)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

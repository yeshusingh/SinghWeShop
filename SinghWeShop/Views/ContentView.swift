//
//  ContentView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var itemStore = ItemsManager()
    @StateObject private var cartStore = CartManager()
    //Homework Week05 : Assignment 1 Tab View - This part remembers last user selected Tab.
    @AppStorage("CurrentTabSelection") var selectedTab = 0
    
    var body: some View {
        //Homework Week05 : Assignment 1 Tab View - Created TabView with Text-SFSymbol & added item badge for cart Tab.
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


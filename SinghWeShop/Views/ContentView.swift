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
                .overlay {
                    if itemStore.allItems.isEmpty { ProgressView() }
                }

            ItemsGridView(items: itemStore.discoverItems)
                .tabItem {
                    Image(systemName: "bolt.square")
                    Text("Discover")
                }
                .tag(1)
                .overlay {
                    if itemStore.allItems.isEmpty { ProgressView() }
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(2)
                .badge(cartStore.cartItems.count)
            
            AccountView(user: itemStore.user)
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
                .tag(3)
            
            ItemsListView(items: itemStore.loadItemsFromPlistFile())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home Plist")
                }
                .tag(4)
            
            ItemsListView(items: itemStore.loadItemsFromFile())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home Binary")
                }
                .tag(5)
        }
        .foregroundColor(Color(Constants.Assets.textColor))
        .environmentObject(cartStore)
        .task {
            do {
                try await itemStore.loadItems()
            } catch { }
        }
        .task {
            do {
                try await itemStore.loadUser()
            } catch { }
        }
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

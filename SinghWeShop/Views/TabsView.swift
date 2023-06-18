//
//  TabView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//
// Current Week 11

import SwiftUI

struct TabsView: View {
  @EnvironmentObject var networkMonitor: NetworkMonitor
  @StateObject private var itemStore = ItemsManager()
  @StateObject private var cartStore = CartManager()
  var userStore: UserManager

  @AppStorage("CurrentTabSelection")
  var selectedTab = 0

  var body: some View {
    TabView(selection: $selectedTab) {
      ItemsListView(items: itemStore.allItems)
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
        .tag(0)
        .overlay {
          if itemStore.allItems.isEmpty && networkMonitor.isConnected { ProgressView() }
        }

      ItemsGridView(items: itemStore.discoverItems)
        .tabItem {
          Image(systemName: "bolt.square")
          Text("Discover")
        }
        .tag(1)
        .overlay {
          if itemStore.allItems.isEmpty && networkMonitor.isConnected { ProgressView() }
        }

      CartView()
        .tabItem {
          Image(systemName: "cart")
          Text("Cart")
        }
        .tag(2)
        .badge(cartStore.cartItems.count)

      AccountView(itemStore: itemStore, cartStore: cartStore, userStore: userStore, user: userStore.user)
        .tabItem {
          Image(systemName: "person")
          Text("Account")
        }
        .tag(3)
    }
    .foregroundColor(Color(Constants.Assets.textColor))
    .environmentObject(cartStore)
    .task {
      do {
        try await ImageStorage.shared.setup()
        try await itemStore.loadItems()
      } catch { print("error: ", error) }
    }
  }
}

#if DEBUG
struct TabsView_Previews: PreviewProvider {
  static var previews: some View {
    TabsView(userStore: UserManager())
      .environmentObject(NetworkMonitor())
  }
}
#endif

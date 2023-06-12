//
//  ItemsListView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ItemsListView: View {
  @EnvironmentObject var cartStore: CartManager
  @EnvironmentObject var networkMonitor: NetworkMonitor
  @State private var searchName = ""
  var items: [Item]

  var matchedItems: [Item] {
    if !searchName.isEmpty {
      return items.filter { $0.name.lowercased().contains(searchName.lowercased()) }
    } else {
      return items
    }
  }

  var matchingItemNames: [String] {
    matchedItems.map { $0.name }
  }

  var body: some View {
    NavigationStack {
      if networkMonitor.isConnected {
        List {
          ForEach(matchedItems) { item in
            NavigationLink(value: item) {
              ListItem(item: item)
            }
            .swipeActions(edge: .leading) {
              Button {
                cartStore.addToCart(item)
              } label: {
                Image(systemName: "highlighter")
                Text("AddToCart")
              }
              .tint(.yellow)
            }
          }
        }
        .listStyle(PlainListStyle())
        .navigationDestination(for: Item.self) { item in
          ItemDetailView(item: item)
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
      } else {
        NetworkStatusView()
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
}

#if DEBUG
struct ItemsListView_Previews: PreviewProvider {
  static var previews: some View {
    ItemsListView(items: ItemsManager().allItems)
      .environmentObject(CartManager())
      .environmentObject(NetworkMonitor())
  }
}
#endif

//
//  ItemsGridView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ItemsGridView: View {
    var items: [Item]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [.init(.adaptive(minimum: 150))]) {
                    ForEach(items) { item in
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
            //.background(Color(Constants.Assets.listBackgroundColor))
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

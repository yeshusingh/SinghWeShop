//
//  ContentView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var itemStore = ItemsManager()
    
    var body: some View {
            NavigationStack {
                ItemListView(items: itemStore.allItems)
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
            .foregroundColor(Color(Constants.Assets.textColor))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


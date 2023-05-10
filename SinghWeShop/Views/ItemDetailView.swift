//
//  ItemDetailView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var cartStore: CartManager
    
    var item: Item
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    if verticalSizeClass == .compact {
                        Image("Item-\(item.id)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .cornerRadius(Constants.General.cornerRadius)
                            .shadow(radius: Constants.General.shadowRadius)
                            .padding(.bottom)
                    } else {
                        Image("Item-\(item.id)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(Constants.General.cornerRadius)
                            .shadow(radius: Constants.General.shadowRadius)
                            .padding(.bottom)
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        HStack() {
                            Text(item.name)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .kerning(0.5)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(-10)
                                .foregroundColor(Color(Constants.Assets.textColor))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Price :")
                                .font(.title2)
                                .fontWeight(.bold)
                                .kerning(0.5)
                                .multilineTextAlignment(.leading)
                            Text("$\(item.price, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.regular)
                                .kerning(0.5)
                                .multilineTextAlignment(.leading)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Description :")
                                .font(.title2)
                                .fontWeight(.bold)
                                .kerning(0.5)
                                .multilineTextAlignment(.leading)
                            Text(item.description)
                                .font(.body)
                                .fontWeight(.regular)
                                .kerning(0.5)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(-10)
                                .foregroundColor(Color(Constants.Assets.textColor))
                        }
                        .padding(.top, 30)
                    
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            cartStore.addToCart(item)
                        } label: {
                            Text("Add to Cart")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(Constants.Assets.textColor))
                                .padding()
                                .background(Color(Constants.Assets.buttonFilledTextColor))
                                .opacity(0.7)
                                .cornerRadius(Constants.General.cornerRadius)
                                .shadow(radius: Constants.General.shadowRadius, x: 5, y: 5)
                        }
                    }
                    .padding(.top, 50)
                }
                .padding()
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: ItemSampleData.eraser)
            .environmentObject(CartManager())
    }
}

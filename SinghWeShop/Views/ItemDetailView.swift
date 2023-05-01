//
//  ItemDetailView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import SwiftUI

struct ItemDetailView: View {
    var item: Item
    
    var body: some View {
        ZStack {
            Color(Constants.Assets.listBackgroundColor)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 10) {
                    Image("Item-\(item.id)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(Constants.General.cornerRadius)
                        .shadow(radius: 10)
                        .padding(.bottom)
                    
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
                            //TODO : Add to Cart method call
                            print("TODO : Add to Cart method call")
                        } label: {
                            Text("Add to Cart")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(Constants.Assets.textColor))
                                .padding()
                                .background(Color(Constants.Assets.buttonFilledTextColor))
                                .opacity(0.7)
                                .cornerRadius(Constants.General.cornerRadius)
                                .shadow(radius: 5)
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
    }
}

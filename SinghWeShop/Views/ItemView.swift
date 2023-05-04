//
//  ItemView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/16/23.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    
    var body: some View {
        VStack(spacing: 10) {
            Image("Item-\(item.id)")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(Constants.General.cornerRadius)
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(-10)
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Price :")
                        .font(.callout)
                        .fontWeight(.bold)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                    Text("$\(item.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: Constants.General.cornerRadius)
                .strokeBorder(lineWidth: Constants.General.strokeBorderWidth/3)
        )
        .background(Color(Constants.Assets.listBackgroundColor))
        .cornerRadius(Constants.General.cornerRadius)
    }
}


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ItemView(item: ItemSampleData.eraser)
            ItemView(item: ItemSampleData.pencil)
        }
    }
}


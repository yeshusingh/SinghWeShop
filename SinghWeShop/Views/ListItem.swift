//
//  ListItem.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ListItem: View {
    var item: Item
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: item.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 100)
                    .cornerRadius(Constants.General.cornerRadius)
            } placeholder: {
                Color.gray.opacity(0.4)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 100)
                    .cornerRadius(Constants.General.cornerRadius)
                    .overlay {
                        ProgressView()
                    }
            }

            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(-10)
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Price :")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                    Text("$\(item.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                }
                
            }
        }
    }
}

#if DEBUG
struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ListItem(item: ItemSampleData.notepad)
            ListItem(item: ItemSampleData.jeans)
        }
    }
}
#endif

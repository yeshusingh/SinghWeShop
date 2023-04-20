//
//  ItemView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/16/23.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var item: Item
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: Constants.ImageLiteral.photoArtframe)
                .imageScale(.large)
                .foregroundColor(Color(Constants.Assets.textColor))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(width: Constants.General.iconPictureSize, height: Constants.General.iconPictureSize)
            
            VStack(alignment: .leading){
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .kerning(0.5)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-10)
                    .foregroundColor(.accentColor)
                
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
                
                Text("\n\(item.description)")
                    .font(.body)
                    .fontWeight(.regular)
                    .kerning(0.1)
                    .multilineTextAlignment(.leading)
            }
            if verticalSizeClass == .compact {
                Spacer()
            }
        }
        .padding()
        .background(Color(Constants.Assets.backgroundColor))
        .cornerRadius(Constants.General.cornerRadius)
    }
}

struct ItemListView: View {
    @Binding var isListViewShowing: Bool
    @Binding var items: Items
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Item List".uppercased())
                    .font(.title2)
                    .fontWeight(.bold)
                    .kerning(1.0)
                    .foregroundColor(Color(Constants.Assets.textColor))
                Spacer()
                
                Button {
                    isListViewShowing = false
                } label: {
                    Image(systemName: Constants.ImageLiteral.xmark)
                        .font(.title)
                        .foregroundColor(Color(Constants.Assets.buttonFilledTextColor))
                        .frame(width: Constants.General.roundButtonSize, height: Constants.General.roundButtonSize)
                        .background(
                            Circle()
                                .fill(Color(Constants.Assets.buttonFilledBackgroundColor))
                        )
                }
            }
            .padding()
            
            ScrollView {
                ForEach(items.showItem()) { item in
                    ItemView(item: item)
                }
            }
            .padding(5)
        }
        .background(Color(Constants.Assets.listBackgroundColor))
    }
}

struct ItemView_Previews: PreviewProvider {
    private static var items = Items()
    static var previews: some View {
        ItemView(item: ItemSampleData.eraser)
        ItemListView(isListViewShowing: .constant(false), items: .constant(items))
    }
}

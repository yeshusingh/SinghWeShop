//
//  CartRowView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct CartRowView: View {
    @EnvironmentObject var cartStore: CartManager
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
            
            VStack(alignment: .leading, spacing: 0) {
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
                        .strikethrough(color: .red)
                }
                
                HStack {
                    Text("Discounted Price :")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                    Text("$\(item.discountedPrice, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .kerning(0.5)
                        .multilineTextAlignment(.leading)
                }
                
                HStack(alignment: .center) {
                    Button {
                        withAnimation(.easeIn(duration: 0.35)) {
                            cartStore.removeFromCart(item)
                        }
                    } label: {
                        Text("Remove")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(Color(Constants.Assets.textColor))
                            .padding(5)
                            .background(.orange.opacity(0.7))
                            .cornerRadius(Constants.General.cornerRadius)
                    }
                }
                .padding(.top, 5)
            }

        }
    }
}

#if DEBUG
struct CartRowView_Previews: PreviewProvider {
    static var previews: some View {
        CartRowView(item: ItemSampleData.jeans)
            .environmentObject(CartManager())
    }
}
#endif

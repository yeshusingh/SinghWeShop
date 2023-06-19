//
//  CartRowView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct CartRowView: View {
  @EnvironmentObject var cartStore: CartManager
  @State var itemImage: UIImage?
  var item: Item

  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      ItemRowImageView(itemImage: itemImage)

      VStack(alignment: .leading, spacing: 0) {
        ItemNameView(name: item.name)
        PriceView(title: "Price: ", price: item.price, strikeThrough: true)
        PriceView(title: "Discounted Price :", price: item.discountedPrice)
        RemoveButtonView(item: item)
      }
    }
    .task {
      do {
        itemImage = try await ImageStorage.shared.image(item.imageURL)
      } catch { print("error: ", error) }
    }
  }
}

#if DEBUG
struct CartRowView_Previews: PreviewProvider {
  static var previews: some View {
    CartRowView(item: ItemSampleData.boatNeckT)
      .environmentObject(CartManager())
      .task {
        do {
          try await ImageStorage.shared.setup()
        } catch { print("error: ", error) }
      }
  }
}
#endif

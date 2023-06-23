//
//  GridItem.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct GridItem: View {
  @State var itemImage: UIImage?
  var item: Item

  var body: some View {
    VStack(spacing: 10) {
      ItemGridImageView(itemImage: itemImage)

      VStack(alignment: .leading, spacing: 2) {
        ItemNameView(name: item.name)
        PriceView(title: "Price: ", price: item.price)
      }
      Spacer()
    }
    .task {
      do {
        itemImage = try await ImageStorage.shared.image(item.imageURL)
      } catch { print("error: ", error) }
    }
  }
}

#if DEBUG
struct GridItem_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      GridItem(item: ItemSampleData.boatNeckT)
      GridItem(item: ItemSampleData.shortSleeve)
    }
    .task {
      do {
        try await ImageStorage.shared.setup()
      } catch { print("error: ", error) }
    }
  }
}
#endif

//
//  ListItem.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ListItem: View {
  @State var itemImage: UIImage?
  var item: Item

  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      ItemRowImageView(itemImage: itemImage)

      VStack(alignment: .leading, spacing: 2) {
        ItemNameView(name: item.name)
        PriceView(title: "Price: ", price: item.price)
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
struct ListItem_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ListItem(item: ItemSampleData.womenTshirt)
      ListItem(item: ItemSampleData.rainJacket)
    }
    .task {
      do {
        try await ImageStorage.shared.setup()
      } catch { print("error: ", error) }
    }
  }
}
#endif

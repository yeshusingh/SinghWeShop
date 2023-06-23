//
//  ItemDetailView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/30/23.
//

import SwiftUI

struct ItemDetailView: View {
  @Environment(\.verticalSizeClass)
  var verticalSizeClass
  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass
  @EnvironmentObject var cartStore: CartManager

  @State var itemImage: UIImage?
  var item: Item

  var body: some View {
    ZStack {
      ScrollView(showsIndicators: false) {
        VStack(spacing: 10) {
          if verticalSizeClass == .compact {
            ItemDetailImageView(itemImage: itemImage, size: 200)
          } else {
            ItemDetailImageView(itemImage: itemImage, size: 300)
          }

          VStack(alignment: .leading, spacing: 5) {
            ItemNameView(name: item.name, font: .title2)

            PriceView(
              title: "Price: ",
              price: item.price,
              titleFont: .title3,
              titleFontWeight: .semibold,
              priceFont: .body
            )

            ItemDescriptionView(description: item.description)
              .padding(.top, 30)
          }

          Spacer()

          Button {
            cartStore.addToCart(item)
          } label: {
            ButtonLabelView(title: "Add to Cart")
          }
        }
        .padding()
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
struct ItemDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ItemDetailView(item: ItemSampleData.boatNeckT)
      .environmentObject(CartManager())
      .task {
        do {
          try await ImageStorage.shared.setup()
        } catch { print("error: ", error) }
      }
  }
}
#endif

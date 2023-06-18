//
//  GridItem.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct GridItem: View {
  var item: Item
  @State var itemImage: UIImage?

  var body: some View {
    VStack(spacing: 10) {
      if let itemImage = itemImage {
        Image(uiImage: itemImage)
          .resizable()
          .aspectRatio(1, contentMode: .fit)
          .cornerRadius(Constants.General.cornerRadius)
          .shadow(radius: Constants.General.shadowRadius / 2)
      } else {
        Color.gray.opacity(0.4)
          .aspectRatio(1, contentMode: .fit)
          .cornerRadius(Constants.General.cornerRadius)
          .shadow(radius: Constants.General.shadowRadius / 2)
          .overlay {
            ProgressView()
          }
      }

      VStack(alignment: .leading, spacing: 5) {
        HStack {
          Text(item.name)
            .font(.body)
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
            .fontWeight(.regular)
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

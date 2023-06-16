//
//  ListItem.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct ListItem: View {
  var item: Item
  @State var itemImage: UIImage?

  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      if let itemImage = itemImage {
        Image(uiImage: itemImage)
          .resizable()
          .aspectRatio(1, contentMode: .fit)
          .frame(width: 100)
          .cornerRadius(Constants.General.cornerRadius)
      } else {
        Color.gray.opacity(0.4)
          .aspectRatio(1, contentMode: .fit)
          .frame(width: 100)
          .cornerRadius(Constants.General.cornerRadius)
          .overlay {
            ProgressView()
          }
      }

      VStack(alignment: .leading, spacing: 10) {
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

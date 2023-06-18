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

  var item: Item
  @State var itemImage: UIImage?

  var body: some View {
    ZStack {
      ScrollView(showsIndicators: false) {
        VStack(spacing: 10) {
          if verticalSizeClass == .compact {
            if let itemImage = itemImage {
              Image(uiImage: itemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(Constants.General.cornerRadius)
                .shadow(radius: Constants.General.shadowRadius)
                .padding(.bottom)
            } else {
              Color.gray.opacity(0.4)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(Constants.General.cornerRadius)
                .overlay {
                  ProgressView()
                }
            }
          } else {
            if let itemImage = itemImage {
              Image(uiImage: itemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(Constants.General.cornerRadius)
                .shadow(radius: Constants.General.shadowRadius)
                .padding(.bottom)
            } else {
              Color.gray.opacity(0.4)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(Constants.General.cornerRadius)
                .overlay {
                  ProgressView()
                }
            }
          }

          VStack(alignment: .leading, spacing: 10) {
            HStack {
              Text(item.name)
                .font(.title2)
                .fontWeight(.semibold)
                .kerning(0.5)
                .multilineTextAlignment(.leading)
                .lineSpacing(-10)
                .foregroundColor(Color(Constants.Assets.textColor))

              Spacer()
            }

            HStack {
              Text("Price :")
                .font(.title3)
                .fontWeight(.semibold)
                .kerning(0.5)
                .multilineTextAlignment(.leading)
              Text("$\(item.price, specifier: "%.2f")")
                .font(.body)
                .fontWeight(.regular)
                .kerning(0.5)
                .multilineTextAlignment(.leading)
            }

            VStack(alignment: .leading) {
              Text("Description :")
                .font(.title3)
                .fontWeight(.semibold)
                .kerning(0.5)
                .multilineTextAlignment(.leading)
              Text(item.description)
                .font(.body)
                .fontWeight(.regular)
                .kerning(0.5)
                .multilineTextAlignment(.leading)
                .lineSpacing(-10)
                .foregroundColor(Color(Constants.Assets.textColor))
            }
            .padding(.top, 30)
          }

          Spacer()

          HStack {
            Button {
              cartStore.addToCart(item)
            } label: {
              Text("Add to Cart")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(Constants.Assets.textColor))
                .padding()
                .background(Color(Constants.Assets.buttonFilledTextColor))
                .cornerRadius(Constants.General.cornerRadius)
                .shadow(radius: Constants.General.shadowRadius, x: 2, y: 3)
            }
          }
          .padding(.top, 30)
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
    ItemDetailView(item: ItemSampleData.shortSleeve)
      .environmentObject(CartManager())
      .task {
        do {
          try await ImageStorage.shared.setup()
        } catch { print("error: ", error) }
      }
  }
}
#endif

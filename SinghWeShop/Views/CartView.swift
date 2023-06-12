//
//  CartView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct CartView: View {
  @EnvironmentObject var cartStore: CartManager

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 20) {
          ForEach(cartStore.cartItems) { item in
            CartRowView(item: item)
          }
        }
        .padding()

        if cartStore.cartItems.isEmpty {
          VStack {
            Text("Your cart is empty.")
          }
          .fontWeight(.medium)
          .padding(30)
          .background(.brown.opacity(0.3))
          .foregroundColor(Color(Constants.Assets.textColor))
          .overlay(
            RoundedRectangle(cornerRadius: Constants.General.cornerRadius)
              .strokeBorder(.orange)
          )
          .clipShape(RoundedRectangle(cornerRadius: Constants.General.cornerRadius))
          .padding([.bottom], 20)
        }

        VStack {
          Divider()
          Section("Order Total") {
            LabeledContent("Total", value: "$\(round(cartStore.totalCartItemsAmount * 100) / 100)")
              .font(.title3)
              .fontWeight(.light)
              .kerning(0.5)
          }
          .padding(5)
          Divider()
        }
        .padding([.horizontal], 30)
        .font(.title)
        .fontWeight(.semibold)
        .kerning(4.0)
        .foregroundColor(Color(Constants.Assets.textColor))

        Button {
          // TODO: Call checkout steps
          print("Checkout Step.")
        } label: {
          Text("Order Now")
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .background(.orange.opacity(0.7))
            .foregroundColor(Color(Constants.Assets.textColor))
            .background(Color(Constants.Assets.buttonFilledTextColor))
            .cornerRadius(Constants.General.cornerRadius)
        }
        .padding(.top, 30)
      }
      .navigationTitle("My Cart")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#if DEBUG
struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    CartView()
      .environmentObject(CartManager())
  }
}
#endif

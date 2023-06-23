//
//  CartView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct CartView: View {
  @Environment(\.verticalSizeClass)
  var verticalSizeClass
  @EnvironmentObject var cartStore: CartManager

  @State private var isShowingCheckoutAlert = false

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 20) {
          Divider()
          ForEach(cartStore.cartItems) { item in
            CartRowView(item: item)
          }
        }
        .padding(20)

        if cartStore.cartItems.isEmpty {
          Text("Your cart is empty.")
            .fontWeight(.medium)
            .foregroundColor(Color(Constants.Assets.textColor))
            .padding(verticalSizeClass == .compact ? 10 : 80)
            .padding([.horizontal, .bottom], 20)
        }

        VStack {
          Divider()
          Section("Cart Total") {
            LabeledContent("Total", value: "$\(Item.formatDecimalDigit(number: cartStore.totalCartItemsAmount))")
              .font(.title3)
              .fontWeight(.light)
              .kerning(0.5)
          }
          .padding(5)
          Divider()
        }
        .padding([.horizontal], 20)
        .font(.title)
        .fontWeight(.semibold)
        .kerning(4.0)
        .foregroundColor(Color(Constants.Assets.textColor))

        Button {
          isShowingCheckoutAlert = true
        } label: {
          ButtonLabelView(title: "Order Now")
        }
        .padding(.top, 30)
      }
      .navigationTitle("My Cart")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        guard cartStore.cartItems.isEmpty else { return }
        cartStore.loadCartFromJSONFile()
      }
      .alert("Checkout", isPresented: $isShowingCheckoutAlert) {
        Button("OK", role: .none) {
          withAnimation { cartStore.clearCart() }
        }
      } message: {
        if cartStore.cartItems.isEmpty {
          Text("Your cart is empty.")
        } else {
          Text("Your order has been placed successfully.")
        }
      }
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

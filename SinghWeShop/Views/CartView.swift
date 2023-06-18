//
//  CartView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/7/23.
//

import SwiftUI

struct CartView: View {
  @EnvironmentObject var cartStore: CartManager

  @Environment(\.verticalSizeClass)
  var verticalSizeClass

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
          VStack {
            Text("Your cart is empty.")
          }
          .frame(maxWidth: .infinity)
          .fontWeight(.medium)
          .padding(verticalSizeClass == .compact ? 10 : 80)
          .foregroundColor(Color(Constants.Assets.textColor))
          .overlay(
            RoundedRectangle(cornerRadius: Constants.General.cornerRadius)
              .strokeBorder(.clear)
          )
          .clipShape(RoundedRectangle(cornerRadius: Constants.General.cornerRadius))
          .padding([.horizontal, .bottom], 20)
        }

        VStack {
          Divider()
          Section("Cart Total") {
            LabeledContent("Total", value: "$\(round(cartStore.totalCartItemsAmount * 100) / 100)")
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
          Text("Order Now")
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(Color(Constants.Assets.textColor))
            .background(Color(Constants.Assets.buttonFilledTextColor))
            .cornerRadius(Constants.General.cornerRadius)
            .shadow(radius: Constants.General.shadowRadius, x: 2, y: 2)
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
          withAnimation {
            cartStore.clearCart()
          }
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

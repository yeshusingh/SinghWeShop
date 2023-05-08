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
            //VStack(spacing: 20) {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(cartStore.cartItems) { item in
                            CartRowView(item: item)
                        }
                    }
                    .padding()
                    
                    Button {
                        //TODO: Call checkout steps
                        
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
                    .padding(.top, 50)

                }
            //}
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

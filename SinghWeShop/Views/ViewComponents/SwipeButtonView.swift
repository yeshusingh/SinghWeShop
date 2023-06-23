//
//  SwipeButtonView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct SwipeButtonView: View {
  @EnvironmentObject var cartStore: CartManager
  var item: Item

  var body: some View {
    Button {
      cartStore.addToCart(item)
    } label: {
      Image(systemName: "highlighter")
      Text("AddToCart")
    }
    .tint(.yellow)
  }
}

#if DEBUG
struct SwipeButtonView_Previews: PreviewProvider {
  static var previews: some View {
    SwipeButtonView(item: ItemSampleData.boatNeckT)
  }
}
#endif

//
//  RemoveButtonView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct RemoveButtonView: View {
  @EnvironmentObject var cartStore: CartManager
  var item: Item

  var body: some View {
    Button {
      withAnimation(.easeIn(duration: 0.35)) {
        cartStore.removeFromCart(item)
      }
    } label: {
      Text("Remove")
        .font(.caption)
        .fontWeight(.medium)
        .foregroundColor(Color(Constants.Assets.textColor))
        .padding([.vertical], 5)
        .padding([.horizontal], 10)
        .background(.orange.opacity(0.7))
        .cornerRadius(Constants.General.cornerRadius)
    }
    .padding(.top, 5)
  }
}

#if DEBUG
struct RemoveButtonView_Previews: PreviewProvider {
  static var previews: some View {
    RemoveButtonView(item: ItemSampleData.boatNeckT)
  }
}
#endif

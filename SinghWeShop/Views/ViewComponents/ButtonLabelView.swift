//
//  ButtonLabelView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ButtonLabelView: View {
  var title: String

  var body: some View {
    Text(title)
      .font(.title2)
      .kerning(2.0)
      .fontWeight(.semibold)
      .padding()
      .background(Color(Constants.Assets.buttonFilledTextColor))
      .foregroundColor(Color(Constants.Assets.textColor))
      .cornerRadius(Constants.General.cornerRadius)
      .shadow(radius: Constants.General.shadowRadius, x: 2, y: 2)
  }
}

#if DEBUG
struct ButtonLabelView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 30) {
      ButtonLabelView(title: "Login")
      ButtonLabelView(title: "Order Now")
      ButtonLabelView(title: "Add to Cart")
    }
  }
}
#endif

//
//  PriceView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct PriceView: View {
  var title: String
  var price: Double
  var strikeThrough = false
  var titleFont: Font = .callout
  var titleFontWeight: Font.Weight = .regular
  var priceFont: Font = .subheadline

  var body: some View {
    HStack {
      Text(title)
        .font(titleFont)
        .fontWeight(titleFontWeight)
        .kerning(0.5)
        .multilineTextAlignment(.leading)

      if strikeThrough {
        Text("$\(Item.formatDecimalDigit(number: price))")
          .font(priceFont)
          .fontWeight(.regular)
          .kerning(0.5)
          .multilineTextAlignment(.leading)
          .strikethrough(color: .red)
      } else {
        Text("$\(Item.formatDecimalDigit(number: price))")
          .font(priceFont)
          .fontWeight(.regular)
          .kerning(0.5)
          .multilineTextAlignment(.leading)
      }
    }
  }
}

#if DEBUG
struct PriceView_Previews: PreviewProvider {
  static var previews: some View {
    PriceView(title: "Price :", price: ItemSampleData.boatNeckT.price)
  }
}
#endif

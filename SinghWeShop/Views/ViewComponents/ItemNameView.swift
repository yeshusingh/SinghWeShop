//
//  ItemNameView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ItemNameView: View {
  var name: String
  var font: Font = .body

  var body: some View {
    HStack {
      Text(name)
        .font(font)
        .fontWeight(.semibold)
        .kerning(0.5)
        .multilineTextAlignment(.leading)
        .lineSpacing(-10)
        .foregroundColor(Color(Constants.Assets.textColor))
      Spacer()
    }
  }
}

#if DEBUG
struct ItemNameView_Previews: PreviewProvider {
  static var previews: some View {
    ItemNameView(name: ItemSampleData.boatNeckT.name)
  }
}
#endif

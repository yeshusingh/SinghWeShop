//
//  ItemDescriptionView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ItemDescriptionView: View {
  var description: String

  var body: some View {
    VStack(alignment: .leading) {
      Text("Description :")
        .font(.title3)
        .fontWeight(.semibold)
        .kerning(0.5)
        .multilineTextAlignment(.leading)
      Text(description)
        .font(.body)
        .fontWeight(.regular)
        .kerning(0.5)
        .multilineTextAlignment(.leading)
        .lineSpacing(-10)
        .foregroundColor(Color(Constants.Assets.textColor))
    }
  }
}

#if DEBUG
struct ItemDescriptionView_Previews: PreviewProvider {
  static var previews: some View {
    ItemDescriptionView(description: ItemSampleData.boatNeckT.description)
  }
}
#endif

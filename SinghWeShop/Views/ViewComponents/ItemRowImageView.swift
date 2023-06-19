//
//  ItemRowImageView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ItemRowImageView: View {
  var itemImage: UIImage?

  var body: some View {
    if let itemImage = itemImage {
      Image(uiImage: itemImage)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 100)
        .cornerRadius(Constants.General.cornerRadius)
    } else {
      Color.gray.opacity(0.4)
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 100)
        .cornerRadius(Constants.General.cornerRadius)
        .overlay {
          ProgressView()
        }
    }
  }
}

#if DEBUG
struct ItemRowImageView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ItemRowImageView()
    }
  }
}
#endif

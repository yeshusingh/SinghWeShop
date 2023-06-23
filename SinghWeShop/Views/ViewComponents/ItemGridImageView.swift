//
//  ItemGridImageView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ItemGridImageView: View {
  var itemImage: UIImage?

  var body: some View {
    if let itemImage = itemImage {
      Image(uiImage: itemImage)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(Constants.General.cornerRadius)
        .shadow(radius: Constants.General.shadowRadius / 2)
    } else {
      Color.gray.opacity(0.4)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(Constants.General.cornerRadius)
        .shadow(radius: Constants.General.shadowRadius / 2)
        .overlay {
          ProgressView()
        }
    }
  }
}

#if DEBUG
struct ItemGridImageView_Previews: PreviewProvider {
  static var previews: some View {
    ItemGridImageView()
  }
}
#endif

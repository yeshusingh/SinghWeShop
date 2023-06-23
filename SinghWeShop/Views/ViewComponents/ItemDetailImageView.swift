//
//  ItemDetailImageView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ItemDetailImageView: View {
  var itemImage: UIImage?
  var size: CGFloat

  var body: some View {
    if let itemImage = itemImage {
      Image(uiImage: itemImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(Constants.General.cornerRadius)
        .frame(width: size, height: size)
        .shadow(radius: Constants.General.shadowRadius)
        .padding(.bottom)
    } else {
      Color.gray.opacity(0.4)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(Constants.General.cornerRadius)
        .frame(width: size, height: size)
        .overlay {
          ProgressView()
        }
    }
  }
}

#if DEBUG
struct ItemDetailImageView_Previews: PreviewProvider {
  static var previews: some View {
    ItemDetailImageView(size: 300)
  }
}
#endif

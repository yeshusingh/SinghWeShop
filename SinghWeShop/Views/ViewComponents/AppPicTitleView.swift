//
//  AppPicTitleView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct AppPicTitleView: View {
  var body: some View {
    VStack(spacing: 5.0) {
      Image(Constants.Assets.iconPicture)
        .resizable()
        .frame(width: Constants.General.iconPictureSize, height: Constants.General.iconPictureSize)
        .clipShape(RoundedRectangle(cornerRadius: Constants.General.cornerRadius))
        .shadow(radius: Constants.General.shadowRadius, x: 2, y: 2)

      Text(Constants.General.appTitle)
        .font(.title)
        .fontWeight(.semibold)
        .kerning(0.5)
        .foregroundColor(Color(Constants.Assets.textColor))
    }
  }
}

#if DEBUG
struct AppPicTitleView_Previews: PreviewProvider {
  static var previews: some View {
    AppPicTitleView()
  }
}
#endif

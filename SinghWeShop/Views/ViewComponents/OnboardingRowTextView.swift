//
//  OnboardingRowTextView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct OnboardingRowTextView: View {
  var imageName: String
  var text: String

  var body: some View {
    HStack {
      Image(systemName: imageName)
        .imageScale(.large)
        .foregroundColor(Color(Constants.Assets.textColor))
        .font(.largeTitle)
        .fontWeight(.semibold)
      Text(text)
        .font(.subheadline)
        .fontWeight(.regular)
        .foregroundColor(Color(Constants.Assets.textColor))
    }
  }
}

#if DEBUG
struct OnboardingRowTextView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingRowTextView(
      imageName: "1.circle",
      text: "Browse the items - You can view items on the homepage and click them to get more details."
    )
  }
}
#endif

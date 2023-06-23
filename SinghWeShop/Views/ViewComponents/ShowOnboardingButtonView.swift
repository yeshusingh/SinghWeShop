//
//  ShowOnboardingButtonView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/18/23.
//

import SwiftUI

struct ShowOnboardingButtonView: View {
  @Binding var isOnboardingViewShowing: Bool

  var body: some View {
    Button {
      isOnboardingViewShowing = true
    } label: {
      Image(systemName: Constants.ImageLiteral.infoCircle)
        .imageScale(.large)
        .foregroundColor(.accentColor)
        .font(.title2)
        .fontWeight(.semibold)
    }
  }
}

#if DEBUG
struct ShowOnboardingButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ShowOnboardingButtonView(isOnboardingViewShowing: .constant(true))
  }
}
#endif

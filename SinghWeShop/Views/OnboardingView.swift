//
//  OnboardingView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//

import SwiftUI

struct OnboardingView: View {
  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass

  var body: some View {
    ZStack {
      ScrollView(showsIndicators: false) {
        VStack(spacing: 5.0) {
          Image(Constants.Assets.iconPicture)
            .resizable()
            .frame(width: Constants.General.iconPictureSize, height: Constants.General.iconPictureSize)
            .clipShape(RoundedRectangle(cornerRadius: Constants.General.cornerRadius))
            .shadow(radius: Constants.General.shadowRadius, x: 5, y: 5)

          Text(Constants.General.appTitle)
            .font(.title)
            .fontWeight(.semibold)
            .kerning(0.5)
            .foregroundColor(Color(Constants.Assets.textColor))

          Text("This is where you come to do all your shopping.")
            .font(.subheadline)
            .fontWeight(.thin)
            .kerning(0.5)
            .foregroundColor(Color(Constants.Assets.textColor))
        }
        .padding(.top, verticalSizeClass == .compact ? 0 : 60)

        VStack(alignment: .leading, spacing: 15) {
          HStack {
            Image(systemName: "1.circle")
              .imageScale(.large)
              .foregroundColor(Color(Constants.Assets.textColor))
              .font(.largeTitle)
              .fontWeight(.semibold)
            Text("Browse the items - You can view items on the homepage and click them to get more details.")
              .font(.subheadline)
              .fontWeight(.regular)
              .foregroundColor(Color(Constants.Assets.textColor))
          }

          HStack {
            Image(systemName: "2.circle")
              .imageScale(.large)
              .foregroundColor(Color(Constants.Assets.textColor))
              .font(.largeTitle)
              .fontWeight(.semibold)
            Text("""
            Add items to the cart as you continue shopping. \
            And the cart will hold all added items in place for checkout.
            """)
              .font(.subheadline)
              .fontWeight(.regular)
              .foregroundColor(Color(Constants.Assets.textColor))
          }

          HStack {
            Image(systemName: "3.circle")
              .imageScale(.large)
              .foregroundColor(Color(Constants.Assets.textColor))
              .font(.largeTitle)
              .fontWeight(.semibold)
            Text("All applicable discounts are applied in the cart at the time of checkout.")
              .font(.subheadline)
              .fontWeight(.regular)
              .foregroundColor(Color(Constants.Assets.textColor))
          }
        }
        .padding(.vertical, verticalSizeClass == .compact ? 0 : 40)
      }
      .padding()
    }
  }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
#endif

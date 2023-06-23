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
  @Environment(\.presentationMode)
  var presentationMode

  var body: some View {
    ScrollView(showsIndicators: false) {
      ZStack(alignment: .top) {
        VStack(spacing: 5.0) {
          AppPicTitleView()

          Text("This is where you come to do all your shopping.")
            .font(.subheadline)
            .fontWeight(.thin)
            .kerning(0.5)
            .foregroundColor(Color(Constants.Assets.textColor))
        }
        .padding(.top, verticalSizeClass == .compact ? 0 : 60)

        HStack {
          Spacer()
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(systemName: Constants.ImageLiteral.xmark)
              .font(.title)
              .foregroundColor(Color(Constants.Assets.buttonFilledTextColor))
              .frame(width: Constants.General.roundButtonSize, height: Constants.General.roundButtonSize)
              .background(
                Circle()
                  .fill(Color(Constants.Assets.buttonFilledBackgroundColor))
              )
          }
          .padding([.horizontal], 5)
        }
      }

      VStack(alignment: .leading, spacing: 15) {
        OnboardingRowTextView(
          imageName: "1.circle",
          text: "Browse the items - You can view items and tap on them to view more details.")
        OnboardingRowTextView(
          imageName: "2.circle",
          text: """
            Add items to the cart as you continue shopping. \
            And the cart will hold all added items in place for checkout.
            """)
        OnboardingRowTextView(
          imageName: "3.circle",
          text: "All applicable discounts are applied in the cart at the time of checkout.")
      }
      .padding(.vertical, verticalSizeClass == .compact ? 0 : 40)
    }
    .padding()
  }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
#endif

//
//  OnboardingView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var isOnboardingViewShowing: Bool
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isOnboardingViewShowing = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(Color("ButtonFilledTextColor"))
                                .frame(width: 56, height: 56)
                                .background(
                                    Circle()
                                        .fill(Color("ButtonFilledBackground"))
                                )
                        }
                    }
                    .padding([.horizontal, .vertical])
                    
                    VStack(spacing: 10.0){
                        Image("IconPicture")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10, x: 5, y: 5)
                        
                        Text("WeShop")
                            .font(.title)
                            .fontWeight(.semibold)
                            .kerning(0.5)
                            .foregroundColor(Color("TextColor"))
                    }
                    
                    Text("This is where you come to do all your shopping.")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .kerning(0.5)
                        .foregroundColor(Color("TextColor"))
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack{
                            Image(systemName: "1.circle")
                                .imageScale(.large)
                                .foregroundColor(.orange)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Text("Browse the items - You can view items on the homepage and click them to get more details.")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        HStack{
                            Image(systemName: "2.circle")
                                .imageScale(.large)
                                .foregroundColor(.orange)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Text("Add items to the cart as you continue shopping. And the cart will hold all added items in place for checkout.")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        HStack{
                            Image(systemName: "3.circle")
                                .imageScale(.large)
                                .foregroundColor(.orange)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Text("You can apply discount coupons in the cart at the time of checkout.")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color("TextColor"))
                        }
                    }
                    .padding(.vertical, verticalSizeClass == .compact ? 10: 50)
                    
                }
                .padding()
            }
            
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingViewShowing: .constant(false))
    }
}

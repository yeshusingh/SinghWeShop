//
//  ContentView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboardingViewShowing = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                WelcomeView(isOnboardingViewShowing: $isOnboardingViewShowing)
            }
            .padding()
            .sheet(isPresented: $isOnboardingViewShowing) {
                OnboardingView(isOnboardingViewShowing: $isOnboardingViewShowing)
            }
        }
    }
}

struct WelcomeView: View {
    @Binding var isOnboardingViewShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Welcome, Yeshu.")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    isOnboardingViewShowing = true
                } label: {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.semibold)
                        
                }
                
            }
            .padding(15)
            
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .strokeBorder(lineWidth:3)
                    .foregroundColor(.accentColor)
                    
                VStack(spacing: 20) {
                    Image(systemName: "figure.fishing")
                        .imageScale(.large)
                        .foregroundColor(Color("TextColor"))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text(
                        """
                        Fishing for more ...\n
                        See more work show up in few weeks
                        """
                    )
                    .font(.body)
                    .multilineTextAlignment(.center)
                }
            }

            Spacer()
        }

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

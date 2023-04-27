//
//  ContentView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboardingViewShowing = false
    @State private var isListViewShowing = false
    
    @State private var items = Items()
    
    var body: some View {
        ZStack {
            Color(Constants.Assets.backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                WelcomeView(isOnboardingViewShowing: $isOnboardingViewShowing, isListViewShowing: $isListViewShowing)
            }
            .padding()
            .sheet(isPresented: $isOnboardingViewShowing) {
                OnboardingView(isOnboardingViewShowing: $isOnboardingViewShowing)
            }
            .sheet(isPresented: $isListViewShowing) {
                ItemListView(isListViewShowing: $isListViewShowing, items: $items)
            }
            
        }
        .onAppear(perform: printTempCartDataForAssginment)
    }

    //Temporary function created to showcase CartItems with individual Discounted prices and the TotalCart amount calculated.
    func printTempCartDataForAssginment() {
        print("Current Cart Items")
        for item in items.cartItems {
            print("\n-------------------------")
            print("Item Name: ", item.name)
            print("Item Price: ", item.price)
            print("Item DiscountedPrice: ", item.discountedPrice)
        }
        print("\n\n-------------------------")
        print("Total Cart Amount : ", items.totalCartItemsAmount)
    }
}


struct WelcomeView: View {
    @Binding var isOnboardingViewShowing: Bool
    @Binding var isListViewShowing: Bool
    
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
                    Image(systemName: Constants.ImageLiteral.infoCircle)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .padding(15)
            
            VStack {
                Button {
                    isListViewShowing = true
                } label: {
                    Text("Show items with URL")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .background {
                            Color.gray
                        }
                        .cornerRadius(Constants.General.cornerRadius)
                        .shadow(radius: 5, x: 5, y: 5)
                }
            }
            .padding()
            
            // Note : Temporary Placeholder view - To be updated as we make progess on the App development.
            ZStack {
                RoundedRectangle(cornerRadius: Constants.General.cornerRadius)
                    .strokeBorder(lineWidth:Constants.General.strokeBorderWidth)
                    .foregroundColor(.accentColor)

                VStack(spacing: 20) {
                    Image(systemName: Constants.ImageLiteral.figureFishing)
                        .imageScale(.large)
                        .foregroundColor(Color(Constants.Assets.textColor))
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


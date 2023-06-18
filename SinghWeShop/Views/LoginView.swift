//
//  LoginView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/16/23.
//

import SwiftUI

struct LoginView: View {
  @Environment(\.verticalSizeClass)
  var verticalSizeClass
  @Environment(\.colorScheme)
  var colorScheme

  @StateObject private var userStore = UserManager()
  @State var userID = ""
  @State var password = ""
  @State var isShowingAlert = false
  @State var errorText = ""

  var service = NetworkManager()

  var body: some View {
    if !userStore.loginState {
      ZStack {
        LinearGradient(
          colors: [.gray.opacity(colorScheme == .dark ? 0.9 : 0.3), .white],
          startPoint: .top,
          endPoint: .bottom
        )
        .ignoresSafeArea()

        VStack(alignment: .center, spacing: 10) {
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
          }
          .padding(verticalSizeClass == .compact ? 10 : 50)

          HStack {
            TextField("UserID", text: $userID, prompt: Text("Enter UserID"))
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .autocorrectionDisabled(true)
              .textInputAutocapitalization(.never)
              .keyboardType(.numberPad)
          }
          .frame(maxWidth: 250)

          HStack(alignment: .center) {
            TextField("Password", text: $password, prompt: Text("Enter Password"))
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .autocorrectionDisabled(true)
              .textInputAutocapitalization(.never)
          }
          .frame(maxWidth: 250)

          Button {
            Task {
              do {
                guard let id = Int(userID) else {
                  setAlert(message: "Invalid UserID.")
                  return
                }
                try await userStore.loadUser(for: id)

                guard let user = userStore.user?.username else {
                  setAlert(message: "Could not identify user based on userID - \(userID).")
                  return
                }

                try await service.performLoginFor(user: user, password: password)
                withAnimation {
                  userStore.loginState = true
                }
              } catch {
                print("error: ", error.localizedDescription)
                setAlert(message: "Login failed.")
              }
            }
          } label: {
            Text("Login")
              .font(.title3)
              .kerning(3.0)
              .fontWeight(.semibold)
              .padding()
              .background(.orange.opacity(0.7))
              .foregroundColor(Color(Constants.Assets.textColor))
              .cornerRadius(Constants.General.cornerRadius)
          }
          .padding(.top, verticalSizeClass == .compact ? 10 : 50)
        }
      }
      .alert("Error", isPresented: $isShowingAlert) {
      } message: {
        Text("\(errorText)")
      }
      .onDisappear {
        userID = ""
        password = ""
      }
    } else {
      TabsView(userStore: userStore)
    }
  }

  func setAlert(message: String) {
    errorText = message
    isShowingAlert = true
  }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
#endif
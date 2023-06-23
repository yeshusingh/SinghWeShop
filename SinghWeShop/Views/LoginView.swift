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

  @StateObject private var networkMonitor = NetworkMonitor()
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
          colors: [.white, .yellow.opacity(colorScheme == .dark ? 0.6 : 0.3), .white],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        VStack(alignment: .center, spacing: 10) {
          AppPicTitleView()
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
            SecureField("Password", text: $password, prompt: Text("Enter Password"))
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .autocorrectionDisabled(true)
              .textInputAutocapitalization(.never)
          }
          .frame(maxWidth: 250)

          if !networkMonitor.isConnected {
            Text("Network connection seems offline.\nPlease check your connection.")
          }

          Button {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                withAnimation(.easeOut(duration: 0.25)) {
                  userStore.loginState = true
                }
              } catch {
                print("error: ", error.localizedDescription)
                setAlert(message: "Login failed.")
              }
            }
          } label: {
            ButtonLabelView(title: "Login")
          }
          .padding(.top, verticalSizeClass == .compact ? 10 : 50)
          .disabled(!networkMonitor.isConnected)
          .opacity(!networkMonitor.isConnected ? 0.6 : 1.0)

          if verticalSizeClass != .compact {
            Spacer()
          }
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
        .environmentObject(networkMonitor)
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

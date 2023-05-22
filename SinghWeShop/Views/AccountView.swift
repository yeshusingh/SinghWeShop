//
//  AccountView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 5/21/23.
//

import SwiftUI

struct AccountView: View {
    let user: User?
    
    var body: some View {
        NavigationStack {
            if let user = user {
                List {
                    Section("Account Details") {
                        LabeledContent("Member ID", value: "\(user.id)")
                    }
                    
                    Section("User Details") {
                        LabeledContent("Username", value: user.username)
                        LabeledContent("Name", value: "\(user.name.firstname) \(user.name.lastname)")
                        LabeledContent("Email", value: user.email)
                        LabeledContent("Phone", value: user.phone)
                    }
                    
                    Section("Shipping Address") {
                        LabeledContent("Street", value: "\(user.address.number.description) \(user.address.street)")
                        LabeledContent("City", value: user.address.city)
                        LabeledContent("ZipCode", value: user.address.zipcode)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Hello, \(user.name.firstname)")
            } else {
                VStack {
                    Text("Account Info not available.")
                }
                .navigationTitle("Hello, there !")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(user: SampleUserInfo.user!)
        AccountView(user: nil)
    }
}

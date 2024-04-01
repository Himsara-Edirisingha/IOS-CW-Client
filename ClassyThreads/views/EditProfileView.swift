//
//  EditProfileView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    @Binding var user: User
    @State private var newName: String = ""
    @State private var newEmail: String = ""
    @State private var newAddress: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $newName)
                    TextField("Email", text: $newEmail)
                    TextField("Address", text: $newAddress)
                }
                
                Section {
                    Button("Save Changes") {
                        user.name = newName.isEmpty ? user.name : newName
                        user.email = newEmail.isEmpty ? user.email : newEmail
                        user.address = newAddress.isEmpty ? user.address : newAddress
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .onAppear {
                newName = user.name
                newEmail = user.email
                newAddress = user.address
            }
        }
    }
}

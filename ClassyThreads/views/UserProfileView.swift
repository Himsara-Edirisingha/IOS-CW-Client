//
//  UserProfileView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userController: LoginViewModel
    @State private var user = User(id: "1", name: "Jane Doe", email: "jane.doe@example.com", address: "123 Main St", imageUrl: "profileImage", username: "janedoe", password: "password", __v: 0)
    @State private var showingEditProfile = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 20)
            
            Text(userController.user?.name ?? user.name)
                .font(.title)
            Text(userController.user?.email ?? user.email)
                .font(.subheadline)
            Text(userController.user?.address ?? user.address)
                .font(.subheadline)
            
            Spacer()
            
            Button("Edit Profile") {
                showingEditProfile = true
            }
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView(user: $user)
            }
            
            Button("Log Out") {
                
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userController:LoginViewModel())
    }
}

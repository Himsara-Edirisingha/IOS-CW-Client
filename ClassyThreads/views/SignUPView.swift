//
//  SignUPView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

import SwiftUI

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var address = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var shouldNavigateToLogin = false
   
       
        var body: some View {
            ZStack {
              
                Image("logbg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)

              
                VStack {
                    Spacer()
                    
                   
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                    
                   
                    Group {
                        InputField(placeholder: "Name", icon: "person.fill", text: $name)
                        InputField(placeholder: "Email", icon: "envelope.fill", text: $email)
                        InputField(placeholder: "Address", icon: "house.fill", text: $address)
                        InputField(placeholder: "Username", icon: "person.fill", text: $username)
                        InputField(placeholder: "Password", icon: "lock.fill", text: $password, isSecure: true)
                        InputField(placeholder: "Confirm Password", icon: "lock.fill", text: $confirmPassword, isSecure: true)
                    }

                   
                    Button(action: signUp) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    
    
                    NavigationLink(destination: LoginView()) {
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.white)
                            Text("Log In")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .padding(.bottom)
                    }
                }
                .padding()
            }.navigationTitle("Login")
                .background(NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) { EmptyView() }.hidden())
        }
    

    func signUp() {
       
        let newUser = User(id: UUID().uuidString,
                             name: name,
                             email: email,
                             address: address,
                             imageUrl: "",
                             username: username,
                             password: password,
                             __v: 0)
        print(newUser)

        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}



struct InputField: View {
    var placeholder: String
    var icon: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.black)
                .padding(.leading)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
                    .padding()
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

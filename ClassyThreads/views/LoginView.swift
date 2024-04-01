    //
    //  LoginView.swift
    //  ClassyThreads
    //
    //  Created by NIBM-LAB04-PC05 on 2024-03-30.
    //

    import Foundation
    import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @StateObject var cartController = CartViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var shouldNavigateToHome = false

    var body: some View {
       
            ZStack {
                Image("logbg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    
                    CustomTextField(placeholder: Text("Email").foregroundColor(.gray), text: $email, isPassword: false)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(placeholder: Text("Password").foregroundColor(.gray), text: $password, isPassword: true)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.loginUser(username: email, password: password)
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 50)
                    .alert(isPresented: $viewModel.showingAlert) {
                        Alert(title: Text("Login Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                    Spacer()
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top)
            }
            .onChange(of: viewModel.authToken) { _ in
                self.shouldNavigateToHome = viewModel.authToken != nil
                cartController.setUser(usr: viewModel.user!)
            }
        .navigationTitle("Login")
        .background(NavigationLink(destination: HomePageView(userController:viewModel,cartManager: cartController), isActive: $shouldNavigateToHome) { EmptyView() })
    }
}
struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var isPassword: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
            }
            if isPassword {
                SecureField("", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField("", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
    }
}


    struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
    }

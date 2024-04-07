//
//  LoginViewModel.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//


import Foundation

class LoginViewModel: ObservableObject {

    @Published var authToken: String?
    @Published var user: User?
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""

    
    func loginUser(username:String,password:String) {
        guard let url = URL(string: "https://ios-back-end.onrender.com/api/login") else {
            self.alertMessage = "Invalid URL"
            self.showingAlert = true
            return
        }

        let requestBody: [String: String] = [
            "username": username,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self?.alertMessage = "Login error: \(error.localizedDescription)"
                        self?.showingAlert = true
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        self?.alertMessage = "No data received"
                        self?.showingAlert = true
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.authToken = result.authtoken
                        self?.user = result.user
                    }
                   
                } catch {
                    DispatchQueue.main.async {
                        self?.alertMessage = "Error decoding JSON: \(error)"
                        self?.showingAlert = true
                    }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async {
                self.alertMessage = "Error serializing JSON: \(error)"
                self.showingAlert = true
            }
        }
    }
}

struct LoginResponse: Codable {
    let authtoken: String
    let user: User
}

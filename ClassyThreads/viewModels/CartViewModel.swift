//
//  CartViewModel.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

class CartViewModel: ObservableObject {
    
    @Published var cartItems = [CartItem]()
    private var user : User?
    @Published var showingAlert: Bool = false
    
    func fetchCartItem(user:User) {
        guard let url = URL(string: "http://192.168.1.9:3001/api/carts/user/\(user.id)") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching categories: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let decoder = JSONDecoder()
            do {
                let fetchedItems = try decoder.decode([CartItem].self, from: data)
                DispatchQueue.main.async {
                    print(fetchedItems)
                    self.cartItems = fetchedItems
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func setUser(usr:User){
        DispatchQueue.main.async {
            self.user = usr;
            print(usr.id)
            self.fetchCartItem(user: usr)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        
        cartItems.remove(atOffsets: offsets)
    }
    
    
    
    func addItem(cartItem: CartItem,user:User) {
        let requestBody: [String: Any] = [
            "userID": user.id,
            "name": cartItem.name,
            "price": cartItem.price,
            "quantity":cartItem.quantity,
            "size": cartItem.size,
            "colour": cartItem.colour,
            "imageName":cartItem.imageName
        ]
        
        guard let url = URL(string: "http://192.168.1.9:3001/api/carts/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    self.showingAlert = true
                }
            }.resume()
        } catch {
            print("Error encoding cart data: \(error.localizedDescription)")
        }
        fetchCartItem(user: user);
       
        //self.cartItems.append(cartItem)
    }
    
    
    
}

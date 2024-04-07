//
//  ProductViewModel.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products = [ProductVM]()
   
    
    init() {
        self.fetchProducts()
    }
     
    func fetchProducts() {
        guard let url = URL(string: "https://ios-back-end.onrender.com/api/products") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching products: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let fetchedProducts = try decoder.decode([ProductVM].self, from: data)
                DispatchQueue.main.async {
                    self.products = fetchedProducts
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

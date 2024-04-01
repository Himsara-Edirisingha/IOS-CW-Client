//
//  CategoriesViewModel.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    
    init() {
        self.fetchCategories()
    }
    
    func fetchCategories() {
        guard let url = URL(string: "http://192.168.1.9:3001/api/categories") else {
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
                let fetchedCategories = try decoder.decode([Category].self, from: data)
                DispatchQueue.main.async {
                    self.categories = fetchedCategories
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

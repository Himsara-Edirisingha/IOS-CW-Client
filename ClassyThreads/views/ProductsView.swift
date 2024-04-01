//
//  ProductsView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation
import SwiftUI
import URLImage

struct ProductListView: View {
    @State private var searchText = ""
    @State var selectedCategory: String = "All"
    @State private var sortByPrice = false
    @StateObject var userController: LoginViewModel
    @StateObject var categoryController = CategoryViewModel()
    @ObservedObject var cartController :CartViewModel
    @ObservedObject var productController : ProductViewModel
    
    
    
    var filteredProducts: [ProductVM] {
        var filtered = productController.products

        if selectedCategory != "All" {
            filtered = filtered.filter { $0.categoryID == selectedCategory }
        }

        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.tags.contains { $0.lowercased().contains(searchText.lowercased()) }
            }
        }

        if sortByPrice {
            filtered = filtered.sorted { $0.price < $1.price }
        } else {
            filtered = filtered.sorted { $0.price > $1.price }
        }
        return filtered
    }

    var body: some View {
       
            VStack {
                TextField("Search...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categoryController.categories, id: \.id) { category in
                            Button(action: {
                                selectedCategory = category.id
                            }) {
                                Text(category.name)
                                    .padding()
                                    .background(selectedCategory == category.id ? Color.yellow : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        Button("All") {
                            selectedCategory = "All"
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                }

                Button("Sort by Price: \(sortByPrice ? "Ascending" : "Descending")") {
                    sortByPrice.toggle()
                }
                .padding()

                List(filteredProducts) { product in
                    NavigationLink(destination: ProductView(product: product, userController: userController, cartController: cartController)) {
                        HStack {
                            URLImage(URL(string: product.imageName)!){image in image.resizable()
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)}
                            VStack(alignment: .leading) {
                                Text(product.name)
                                Text("Rs. \(product.price)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationBarTitle("Products").navigationViewStyle(StackNavigationViewStyle())
               
            }
        }
        
    }


struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(selectedCategory: "All",userController:LoginViewModel(),cartController: CartViewModel(),productController: ProductViewModel())
    }
}

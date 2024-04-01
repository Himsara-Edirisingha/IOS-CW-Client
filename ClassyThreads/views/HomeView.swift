//
//  HomeView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

import SwiftUI
import URLImage

struct HomePageView: View {
    @ObservedObject var userController:LoginViewModel
    let promotionalText = "Season Sale - Up to 50% Off!"
    @StateObject var productController = ProductViewModel()
    @StateObject  var categoryController = CategoryViewModel()
    @StateObject var cartManager : CartViewModel
    @State private var istoProduct = false
    @State private var isActive = false
    @State private var isToCart = false
    var fproducts :[ProductVM]{return productController.products}
    var categories2 :[Category]{return categoryController.categories}
    
    
    var body: some View {
        
        ScrollView {
            NavigationLink(destination: UserProfileView(userController:userController), isActive: $isActive) {
                EmptyView()
            }.hidden()
            NavigationLink(destination: CartView(cartVariable: cartManager), isActive: $isToCart) {
                EmptyView()
            }.hidden()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                        .onTapGesture {
                            isActive = true
                        }
                    
                    Image(systemName: "cart.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                        .onTapGesture {
                            isToCart = true
                        }
                }
                
                
                Image("banner")
                    .resizable()
                    .scaledToFit()
                
                Text("Categories")
                    .font(.headline)
                    .padding(.leading)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(categories2, id: \.id) { category in
                        NavigationLink(destination: ProductListView(selectedCategory: category.id ,userController: userController,cartController: cartManager,productController: productController)) {
                            CategoryView(category: category)
                        }
                    }
                }
                .padding()
                
                Text(promotionalText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 5)
                
                Text("Featured Products")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(fproducts, id: \.id) { product in
                            FeaturedProductView(product: product)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    
    struct CategoryView: View {
        let category: Category
        
        var body: some View {
            VStack {
                URLImage(URL(string: category.imageName)!){image in image.resizable()
                        .scaledToFit()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                        .background(Color.gray)
                    .cornerRadius(10)}
                
                
                Text(category.name)
            }
        }
    }
    
    struct FeaturedProductView: View {
        let product: ProductVM
        
        var body: some View {
            VStack {
                URLImage(URL(string: product.imageName)!){image in image.resizable()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Text(product.name)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }

}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(userController: LoginViewModel(),cartManager: CartViewModel())
    }
}

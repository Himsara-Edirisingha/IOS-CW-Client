//
//  ProductItemView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation
import SwiftUI
import URLImage

struct ProductView: View {
    let product: ProductVM
    @StateObject var userController: LoginViewModel
    @ObservedObject var cartController: CartViewModel
    @State private var selectedSize: String = ""
    @State private var selectedColor: String = ""
    @State private var quantity: Int = 1
    @State private var isActive = false

    var body: some View {
        ScrollView {
            NavigationLink(destination: CartView(cartVariable: cartController), isActive: $isActive) {
                EmptyView()
            }
            .hidden()

            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Spacer()
                    Text("Details")
                        .font(.title)
                    Spacer()
                    Image(systemName: "cart").onTapGesture {
                        isActive = true;
                    }
                    Spacer()
                }
                .padding()

                
                    URLImage(URL(string: product.imageName)!) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                
                
                    Text(product.name)
                        .font(.title)
                        .fontWeight(.bold)

                    HStack {
                        Text("Rs.\(product.price)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(product.availability) products")
                            .foregroundColor(.gray)
                    }
                    .padding()

                    Text("Description")
                        .fontWeight(.bold)
                    Text(product.description)
                        .foregroundColor(.gray)
                        .padding(.bottom)

                    if !product.availablesize.isEmpty {
                        Picker("Select Size", selection: $selectedSize) {
                            ForEach(product.availablesize, id: \.self) { size in
                                Text(size).tag(size)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    if !product.availablecolor.isEmpty {
                        Picker("Select Color", selection: $selectedColor) {
                            ForEach(product.availablecolor, id: \.self) { color in
                                Text(color).tag(color)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Stepper(value: $quantity, in: 1...100) {
                        Text("Quantity: \(quantity)")
                    }
                    .padding()

                    Button("Add to Cart") {
                        let newItem = CartItem(id: "1",
                                               name: product.name,
                                               price: product.price,
                                               quantity: quantity,
                                               colour:selectedColor,
                                               size: selectedSize,
                                               imageName: product.imageName,
                                               __v: 0)
                        cartController.addItem(cartItem: newItem, user:userController.user!)
                        
                    }.alert(isPresented: $cartController.showingAlert, content: {
                        Alert(title: Text("Item Added!"), message: Text("Successfull!!"), dismissButton: .default(Text("OK")))
                    })
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: ProductVM(id: "1",
                                       name: "Blue Gown ",
                                       price: 3000,
                                       categoryID: "Gowns",
                                       imageName: "spimg",
                                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                                       availability: 100,
                                       tags: ["Citrus", "Vitamin C"],
                                       availablesize: ["Small", "Medium", "Large"],
                                       availablecolor: ["Orange","Pink"]),userController: LoginViewModel(),cartController: CartViewModel())
    }
}

//
//  CartView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation
import SwiftUI
import URLImage

struct CartView: View {
    @ObservedObject var cartVariable: CartViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cartVariable.cartItems.indices, id: \.self) { index in
                    let _ = cartVariable.cartItems[index]
                    CartItemRow(item: $cartVariable.cartItems[index])
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Cart")
            .toolbar {
                EditButton()
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(trailing: Button(action: {
              
            }) {
                Text("Checkout")
            })
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    func removeItems(at offsets: IndexSet) {
        cartVariable.removeItems(at: offsets)
    }
}

struct CartItemRow: View {
    @Binding var item: CartItem
   
    
    var body: some View {
        HStack {
                
            URLImage(URL(string: item.imageName)!){image in image.resizable()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)}
            
            VStack(alignment: .leading) {
                Text(item.name)
                Text("Colour \(item.colour)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Size \(item.size)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Rs. \(item.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Stepper(value: $item.quantity, in: 0...10) {
                    Text("Qty: \(item.quantity)")
                }
            }
        }
    }
}

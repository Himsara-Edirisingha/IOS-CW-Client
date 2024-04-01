//
//  LoadingView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @State private var isActive = false
    var body: some View {
        VStack {
            NavigationLink(destination: LoginView(), isActive: $isActive) {
                EmptyView()
            }.hidden()
            Image("loadingbg")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Classy Threads")
                    .font(.custom("ElegantFontName", size: 24))
                    .padding()
                           
                         
            Text("Where Elegance Meets Style")
                     .font(.custom("StylishFontName", size: 18))
                     .padding(.bottom, 30)
           
            Button(action: {
                self.isActive = true
            }) {
                Text("Get Started")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10).padding(.horizontal)
                    .fontWeight(.bold)
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

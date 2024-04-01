//
//  ContentView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            LoadingView()
        } .navigationViewStyle(StackNavigationViewStyle())
      
    }
}

#Preview {
   ContentView()
}

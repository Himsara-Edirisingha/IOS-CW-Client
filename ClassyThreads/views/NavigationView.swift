//
//  NavigationView.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
          
            Text("Fast Food").tabItem {
                Image(systemName: selectedTab == 0 ? "flame.fill" : "flame")
                Text("Fast Food")
            }
            .tag(0)
            .accentColor(selectedTab == 0 ? .yellow : .gray)

            Text("Vegetables").tabItem {
                Image(systemName: selectedTab == 1 ? "leaf.fill" : "leaf")
                Text("Vegetables")
            }
            .tag(1)
            .accentColor(selectedTab == 1 ? .yellow : .gray)

            Text("Fruits").tabItem {
                Image(systemName: selectedTab == 2 ? "applelogo" : "apple.fill")
                Text("Fruits")
            }
            .tag(2)
            .accentColor(selectedTab == 2 ? .yellow : .gray)
        }
        .accentColor(.yellow)
        .onAppear {
           
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor.systemBackground

            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemYellow
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
           
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
           
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
  
    }
}

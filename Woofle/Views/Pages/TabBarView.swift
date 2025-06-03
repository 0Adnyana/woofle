//
//  TabView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 29/05/25.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(.systemBackground)) // Set your desired background color here
        
        // Optional: Customize selection indicator or shadow if needed
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                StartTournamentView()
                    .tabItem {
                        Label("Tournament", systemImage: "dog.circle")
                    }
                
                WinnerDogListView()
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }
            }
            .tint(Color(hex: "9E5922"))
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
}

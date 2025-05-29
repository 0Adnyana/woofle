//
//  TabView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 29/05/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
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
}

#Preview {
    TabBarView()
}

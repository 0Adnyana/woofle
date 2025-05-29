//
//  RootView.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 29/05/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppStateViewModel()

    var body: some View {
        if appState.isUserOnboarded {
            HomeViewDemo()
                .environmentObject(appState)
        } else {
            HomePageStartTournament()
                .environmentObject(appState)
        }
    }
}


#Preview {
    RootView()
}

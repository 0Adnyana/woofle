//
//  RootView.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 29/05/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appState = OnboardingViewModel()
    @StateObject private var tournamentVM = TournamentViewModel(
        userService: UserStorageService(),
        matchingService: TournamentMatchingService(),
        engine: TournamentEngine(),
        winnersStorage: PastWinnersStorageService()
    )
    
    var body: some View {
        if appState.isUserOnboarded {
            TabBarView()
                .environmentObject(appState)
                .environmentObject(tournamentVM)
        } else {
            StartView()
                .environmentObject(appState)
                .environmentObject(tournamentVM)
        }
    }
}


#Preview {
    RootView()
}

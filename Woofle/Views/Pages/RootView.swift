//
//  RootView.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 29/05/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var profileVM = ProfileViewModel()
    @StateObject private var tournamentVM = TournamentViewModel(
        userService: UserStorageService(),
        matchingService: TournamentMatchingService(),
        engine: TournamentEngine(),
        winnersStorage: PastWinnersStorageService()
    )
    
    var body: some View {
        if profileVM.isUserOnboarded {
            TabBarView()
                .environmentObject(profileVM)
                .environmentObject(tournamentVM)
        } else {
            StartView()
                .environmentObject(profileVM)
                .environmentObject(tournamentVM)
        }
    }
}


#Preview {
    RootView()
}

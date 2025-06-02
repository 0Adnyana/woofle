//
//  RootView.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 01/06/25.
//

import SwiftUI

struct RootView: View {
        @StateObject private var tournamentVM = TournamentViewModel(
            userService: UserStorageService(),
            matchingService: TournamentMatchingService(),
            engine: TournamentEngine(),
            winnersStorage: PastWinnersStorageService()
        )
    @StateObject private var userVM = UserViewModel()
        
        var body: some View {
            if userVM.isUserOnboarded {
                TabBarView()
                    .environmentObject(tournamentVM)
                    .environmentObject(userVM)
            } else {
                WelcomeView()
                    .environmentObject(tournamentVM)
                    .environmentObject(userVM)
            }
        }
}

#Preview {
    RootView()
}

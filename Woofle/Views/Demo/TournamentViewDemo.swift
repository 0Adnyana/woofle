//
//  TournamentViewDemo.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 23/05/25.
//

import SwiftUI

struct TournamentViewDemo: View {
    @ObservedObject var tournamentVM: TournamentViewModel
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                Text("Round \(tournamentVM.currentRound + 1)")
                    .font(.title)

                if !tournamentVM.isTournamentFinished && tournamentVM.currentMatch != nil {
                    VStack(spacing: 20) {
                        Text(tournamentVM.matchProgressText)

                        ForEach(tournamentVM.currentMatch!, id: \.id) { dog in
                            Button(action: {
                                tournamentVM.selectWinner(dog)
                            }) {
                                VStack {
                                    Text(dog.name).font(.title)
                                    Text(dog.breed).font(.subheadline)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                            }
                        }
                    }
                } else {
                    Button(action: {
                        path.append(.home)
                    }) {
                        HStack {
                            Text("Back to Home")
                        }
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .font(.headline)
                        .foregroundColor(.white)
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .tournament:
                    TournamentViewDemo(tournamentVM: tournamentVM)
                case .home:
                    HomeViewDemo()
                }
            }
        }
    }
}

#Preview {
    let fallbackUser = UserProfile(
        id: UUID(),
        name: "Preview User",
        gender: .other,
        age: 25,
        location: GeoLocation(latitude: -8.67, longitude: 115.21),
        preferences: .init(
            preferredBreeds: nil,
            sizePreferences: [.medium],
            activityLevels: [.moderate],
            goodWithKids: false,
            goodWithOtherDogs: nil,
            personalityPreferences: [.playful],
            preferredRadius: 30
        )
    )

    let userService = UserStorageService()
    let matchingService = TournamentMatchingService()
    let engine = TournamentEngine()
    let winnersStorage = PastWinnersStorageService()

    let vm = TournamentViewModel(
        userService: userService,
        matchingService: matchingService,
        engine: engine,
        winnersStorage: winnersStorage
    )

    // Injecting dummy user into storage (preview-safe write)
    userService.save(fallbackUser)

    vm.startNewTournament(
        dogs: DummyData.dogs,
        shelters: DummyData.shelters
    )

    return TournamentViewDemo(tournamentVM: vm)
}


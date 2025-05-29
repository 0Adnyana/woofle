//
//  HomeViewDemo.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 23/05/25.
//

import SwiftUI

struct HomeViewDemo: View {
    @EnvironmentObject var tournamentVM: TournamentViewModel
    @State private var path: [Route] = []

    private let dogs = DummyData.dogs
    private let shelters = DummyData.shelters

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button(action: {
                    tournamentVM.startNewTournament(
                        dogs: dogs,
                        shelters: shelters
                    )
                    path.append(.tournament)
                }) {
                    HStack {
                        Text("New Tournament")
                    }
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .font(.headline)
                    .foregroundColor(.white)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .tournament:
                    TournamentViewDemo(tournamentVM: tournamentVM, path: $path)
                case .home:
                    HomeViewDemo()
                }
            }
        }
    }
}

enum Route: Hashable {
    case tournament
    case home
}

#Preview {
    HomeViewDemo()
        .environmentObject(
            TournamentViewModel(
                userService: UserStorageService(),
                matchingService: TournamentMatchingService(),
                engine: TournamentEngine(),
                winnersStorage: PastWinnersStorageService()
            )
        )
}


//struct HomeViewDemo: View {
//    @StateObject private var tournamentVM: TournamentViewModel
//
//    @State private var path: [Route] = []
//
//    // Shared services
//    private let userService = UserStorageService()
//    private let matchingService = TournamentMatchingService()
//    private let engine = TournamentEngine()
//    private let winnersStorage = PastWinnersStorageService()
//
//    private let dogs = DummyData.dogs
//    private let shelters = DummyData.shelters
//
//    init() {
//        let userService = UserStorageService()
//        let matchingService = TournamentMatchingService()
//        let engine = TournamentEngine()
//        let winnersStorage = PastWinnersStorageService()
//
//        let tournamentVM = TournamentViewModel(
//            userService: userService,
//            matchingService: matchingService,
//            engine: engine,
//            winnersStorage: winnersStorage
//        )
//
//        _tournamentVM = StateObject(wrappedValue: tournamentVM)
//
//        // Save fallback user at init (safe for dev)
//        let fallbackUser = UserProfile(
//            id: UUID(),
//            name: "Fallback User",
//            gender: .other,
//            age: 25,
//            location: GeoLocation(latitude: -8.67, longitude: 115.21),
//            preferences: .init(
//                preferredBreeds: nil,
//                sizePreferences: [.medium],
//                activityLevels: [.moderate],
//                goodWithKids: true,
//                goodWithOtherDogs: nil,
//                personalityPreferences: [.playful],
//                preferredRadius: 30
//            )
//        )
//        userService.save(fallbackUser)
//    }
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            VStack {
//                Button(action: {
//                    tournamentVM.startNewTournament(
//                        dogs: dogs,
//                        shelters: shelters
//                    )
//                    path.append(.tournament)
//                }) {
//                    HStack {
//                        Text("New Tournament")
//                    }
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(15)
//                    .font(.headline)
//                    .foregroundColor(.white)
//                }
//            }
//            .navigationDestination(for: Route.self) { route in
//                switch route {
//                case .tournament:
//                    TournamentViewDemo(tournamentVM: tournamentVM, path: $path)
//                case .home:
//                    HomeViewDemo()
//                }
//            }
//        }
//    }
//}
//
//enum Route: Hashable {
//    case tournament
//    case home
//}
//
//#Preview {
//    HomeViewDemo()
//}

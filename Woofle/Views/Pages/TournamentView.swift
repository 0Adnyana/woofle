//
//  TournamentView.swift
//  Woofle
//
//  Created by Jesse Brown on 22/5/2025.
//

import SwiftUI

struct TournamentView: View {
    @EnvironmentObject var tournamentVM: TournamentViewModel
    @State private var selectedDog: Dog?
    @State private var selectedShelter: Shelter?
    @State private var showDetails = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                if tournamentVM.phase == .inProgress,
                   let match = tournamentVM.currentMatch {
                    headerView
                    matchView(match)
                }

                if tournamentVM.phase == .finished,
                   let winner = tournamentVM.winners.first,
                   let shelter = tournamentVM.shelter(for: winner) {
                    CongratulationsView(dog: winner, shelter: shelter)
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showDetails) {
            detailSheet
        }
    }


    private var headerView: some View {
        Text(tournamentVM.matchProgressText)
            .font(.title)
            .bold()
            .padding(.top)
    }

    @ViewBuilder
    private func matchView(_ match: [Dog]) -> some View {
        if match.count == 2 {
            VStack(alignment: .center, spacing: 16) {
                if let shelter1 = tournamentVM.shelter(for: match[0]),
                   let shelter2 = tournamentVM.shelter(for: match[1]) {

                    DogCard(dog: match[0], shelter: shelter1, onSelect: {
                        tournamentVM.selectWinner(match[0])
                    })

                    Text("—————— VS ——————")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(minWidth: 40)

                    DogCard(dog: match[1], shelter: shelter2, onSelect: {
                        tournamentVM.selectWinner(match[1])
                    })
                } else {
                    Text("Missing shelter data")
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 8)
        } else {
            Text("Invalid match configuration.")
                .foregroundColor(.red)
        }
    }

    private var detailSheet: some View {
        Group {
            if let dog = selectedDog, let shelter = selectedShelter {
                DogDetailView(dog: dog, shelter: shelter) {}
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(25)
            }
        }
    }
}

#Preview {
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

    vm.startNewTournament(
        dogs: DummyData.dogs,
        shelters: DummyData.shelters
    )

    return TournamentView()
        .environmentObject(vm)
}


//#Preview {
//    let fallbackUser = UserProfile(
//        id: UUID(),
//        name: "Preview User",
//        gender: .other,
//        age: 25,
//        location: GeoLocation(latitude: -8.67, longitude: 115.21),
//        preferences: .init(
//            preferredBreeds: nil,
//            sizePreferences: [.medium],
//            genderPreferences: [.female, .male],
//            activityLevels: [.moderate],
//            goodWithKids: false,
//            goodWithOtherDogs: nil,
//            personalityPreferences: [.playful],
//            preferredRadius: 30
//        )
//    )
//
//    let userService = UserStorageService()
//    let matchingService = TournamentMatchingService()
//    let engine = TournamentEngine()
//    let winnersStorage = PastWinnersStorageService()
//
//    let vm = TournamentViewModel(
//        userService: userService,
//        matchingService: matchingService,
//        engine: engine,
//        winnersStorage: winnersStorage
//    )
//
//    // Injecting dummy user into storage (preview-safe write)
////    userService.save(fallbackUser)
//
//    vm.startNewTournament(
//        dogs: DummyData.dogs,
//        shelters: DummyData.shelters
//    )
//
//    TournamentView().environmentObject(vm)
//}


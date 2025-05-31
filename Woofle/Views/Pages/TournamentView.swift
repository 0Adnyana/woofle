//
//  TournamentView.swift
//  Woofle
//
//  Created by Jesse Brown on 22/5/2025.
//

import SwiftUI

struct TournamentView: View {
    @ObservedObject var tournamentVM: TournamentViewModel
    @Binding var path: [Route]

    @State private var selectedDog: Dog?
    @State private var selectedShelter: Shelter?
    @State private var showDetails = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Round \(tournamentVM.currentRound + 1) of \(tournamentVM.rounds.count)")
                    .font(.title)
                    .bold()
                    .padding(.top)

                if tournamentVM.phase == .inProgress, let match = tournamentVM.currentMatch {
                    ForEach(match, id: \.id) { dog in
                        DogCard(dog: dog) {
                            tournamentVM.selectWinner(dog)
                        } onInfoTap: {
                            selectedDog = dog
                            selectedShelter = tournamentVM.shelters.first(where: { $0.id == dog.shelterID })
                            showDetails = true
                        }
                    }

                    if match.count == 2 {
                        Text("—————— VS ——————")
                            .font(.headline)
                            .padding(.vertical, 8)
                    }
                } else {
                    Button("Back to Home") {
                        path = []
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showDetails) {
            if let dog = selectedDog, let shelter = selectedShelter {
                DogDetailView(dog: dog, shelter: shelter) {}
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(25)
            }
        }
    }
}



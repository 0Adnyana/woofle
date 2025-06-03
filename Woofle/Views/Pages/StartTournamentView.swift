//
//  HomePageStartTournament.swift
//  Woofle
//
//  Created by Rahel on 22/05/25.
//

import SwiftUI

struct StartTournamentView: View {
    @EnvironmentObject var tournamentVM: TournamentViewModel
    @State private var navigateToTournament = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Woofle")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Spacer()

                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(hex: "A3B18A"))
                    }
                }
                .padding(.horizontal)

                Spacer()

                // CTA
                Text("Find your perfect dog")
                    .font(.title)
                    .padding(.bottom, 20)

                Button(action: {
                    tournamentVM.startNewTournament(
                        dogs: DummyData.dogs,
                        shelters: DummyData.shelters
                    )
                    navigateToTournament = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "DFE4D6"))
                            .frame(width: 210, height: 210)
                        Image("PawPrint")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 255, height: 255)
                    }
                }

                // Animated dog GIF
                HStack {
                    Spacer()
                    if let frames = extractFramesFromGIF(named: "Shiba Inu") {
                        FrameAnimator(frames: frames)
                            .frame(width: 150)
                            .padding()
                    }
                }
                // NavigationLink trigger
                .navigationDestination(isPresented: $navigateToTournament) {
                    TournamentView()
                }
            }
        }
    }
}


#Preview {
    StartTournamentView()
        .environmentObject(UserViewModel())
        .environmentObject(TournamentViewModel())// Inject the required environment object
}

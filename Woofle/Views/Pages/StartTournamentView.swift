//
//  HomePageStartTournament.swift
//  Woofle
//
//  Created by Rahel on 22/05/25.
//

import SwiftUI

struct StartTournamentView: View {
    @EnvironmentObject var tournamentVM: TournamentViewModel
    @State private var path: [Route] = []

    private let dogs = DummyData.dogs
    private let shelters = DummyData.shelters
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                
                Spacer()
                
                // Center content
                Text("Find your perfect dog")
                    .font(.title)
                    .padding(.bottom, 20)
                Button(action: {
                    tournamentVM.startNewTournament(
                        dogs: dogs,
                        shelters: shelters
                    )
                    path.append(.tournament)
                }){
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
                
                Spacer()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Woofle")
                            .font(.title) // Customize size
                            .fontWeight(.bold) // Customize weight
                            .foregroundColor(.primary) // Customize color
                        Spacer() // Push title to the left
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: ProfileView()
                    ) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(hex: "A3B18A"))
                    }
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

#Preview {
    StartTournamentView()
        .environmentObject(
            TournamentViewModel(
                userService: UserStorageService(),
                matchingService: TournamentMatchingService(),
                engine: TournamentEngine(),
                winnersStorage: PastWinnersStorageService()
            )
        )
}

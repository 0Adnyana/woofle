//
//  HomeViewDemo.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 23/05/25.
//

import SwiftUI

struct HomeViewDemo: View {
    @StateObject private var pastWinnersVM = PastWinnersViewModel()
    @StateObject private var tournamentVM: TournamentViewModel
    @StateObject private var dogListVM = DogListViewModel(dogs: (DummyData.dogs))
    @StateObject private var shelterListVM = ShelterListViewModel(shelters: DummyData.shelters)
    
    @State private var path: [Route] = []
    

    init() {
        let tournamentVM = TournamentViewModel(
            userService: UserStorageService(),
            matchingService: TournamentMatchingService(),
            engine: TournamentEngine(),
            winnersStorage: PastWinnersStorageService()
        )
        _tournamentVM = StateObject(wrappedValue: tournamentVM)
    }

    var body: some View {
        let dogs = dogListVM.dogs
        let shelters = shelterListVM.shelters

        NavigationStack (path: $path) {
            VStack {
                Button (action: {
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
                case .tournament: TournamentViewDemo(tournamentVM: tournamentVM)
                case .home: HomeViewDemo()
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
}

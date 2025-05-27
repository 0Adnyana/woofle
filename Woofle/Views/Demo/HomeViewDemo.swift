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
    @StateObject private var userVM = UserViewModel()
    @StateObject private var dogListVM = DogListViewModel(dogs: (DummyData.dogs))
    @StateObject private var shelterListVM = ShelterListViewModel(shelters: DummyData.shelters)
    
    @State private var path: [Route] = []
    
    init() {
        let pastWinnersVM = PastWinnersViewModel()
        _pastWinnersVM = StateObject(wrappedValue: pastWinnersVM)
        _tournamentVM = StateObject(wrappedValue: TournamentViewModel(pastWinnersVM: pastWinnersVM))
    }

    var body: some View {
        let user = userVM.user
        let dogs = dogListVM.dogs
        let shelters = shelterListVM.shelters

        NavigationStack (path: $path) {
            VStack {
                Button (action: {
                    tournamentVM.startNewTournament(
                        user: user,
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

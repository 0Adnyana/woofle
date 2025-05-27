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
        NavigationStack (path: $path) {
            ScrollView {
                Text("Round \(tournamentVM.currentRound + 1)").font(.title)
                if !tournamentVM.isTournamentFinished && tournamentVM.hasMoreRounds {
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
                    Button (action: {
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
                case .tournament: TournamentViewDemo(tournamentVM: tournamentVM)
                case .home: HomeViewDemo()
                }
            }
        }
    }
}


#Preview {
    let userVM = UserViewModel()
    let shelterVM = ShelterListViewModel(shelters: DummyData.shelters)
    let pastWinnersVM = PastWinnersViewModel()
    let dogVM = DogListViewModel(dogs: DummyData.dogs)
    
    TournamentViewDemo(
        tournamentVM: {
            let vm = TournamentViewModel(pastWinnersVM: pastWinnersVM)
            vm.startNewTournament(
                user: userVM.user,
                dogs: dogVM.dogs,
                shelters: shelterVM.shelters
            )
            return vm
        }()
    )
    
    

}


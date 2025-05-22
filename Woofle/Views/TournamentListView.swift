//
//  TournamentListView.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import SwiftUI

struct TournamentListView: View {
    @ObservedObject var viewModel: TournamentViewModel
    let allDogs: [Dog]
    let user: UserProfile
    let shelters: [Shelter]

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.selectedDogIds, id: \.self) { id in
                    if let dog = allDogs.first(where: { $0.id == id }) {
                        VStack(alignment: .leading) {
                            Text(dog.name).font(.headline)
                            Text(dog.breed).font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Top 16 Dogs")
            .toolbar {
                Button("Generate") {
                    viewModel.generateTournament(user: user, dogs: allDogs, shelters: shelters)
                }
            }
        }
    }
}

#Preview {
    TournamentListView_Preview.make()
}

private enum TournamentListView_Preview {
    static func make() -> some View {
        let dogListVM = DogListViewModel()
        let shelterListVM = ShelterListViewModel()
        let userVM = UserViewModel()

        let vm = TournamentViewModel()
        vm.generateTournament(user: userVM.user, dogs: dogListVM.dogs.map { $0.dog }, shelters: shelterListVM.shelters.map { $0.shelter })

        return TournamentListView(
            viewModel: vm,
            allDogs: dogListVM.dogs.map { $0.dog },
            user: userVM.user,
            shelters: shelterListVM.shelters.map { $0.shelter }
        )
    }
}


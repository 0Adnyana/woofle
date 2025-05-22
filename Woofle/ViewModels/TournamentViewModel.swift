//
//  TournamentViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

final class TournamentViewModel: ObservableObject {
    @Published var selectedDogIds: [UUID] = []
    @Published var selectedDogs: [Dog] = []

    func generateTournament(user: UserProfile, dogs: [Dog], shelters: [Shelter]) {
        let result = TournamentSelector.run(user: user, dogs: dogs, shelters: shelters)
        self.selectedDogIds = result.dogIds
        self.selectedDogs = dogs.filter { result.dogIds.contains($0.id) }
        saveToUserDefaults(result.dogIds)
    }

    func loadPreviousTournament(dogs: [Dog]) {
        guard let data = UserDefaults.standard.data(forKey: "tournament_dog_ids"),
              let ids = try? JSONDecoder().decode([UUID].self, from: data) else {
            return
        }
        self.selectedDogIds = ids
        self.selectedDogs = dogs.filter { ids.contains($0.id) }
    }

    private func saveToUserDefaults(_ ids: [UUID]) {
        if let encoded = try? JSONEncoder().encode(ids) {
            UserDefaults.standard.set(encoded, forKey: "tournament_dog_ids")
        }
    }
}




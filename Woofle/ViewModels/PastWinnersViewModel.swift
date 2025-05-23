//
//  PastWinnersViewModel.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 23/05/25.
//

import Foundation

final class PastWinnersViewModel: ObservableObject {
    @Published var winnerIds: [UUID] = []

    private let fileName = "past_winners.json"

    init() {
        load()
    }

    func addWinners(_ dogs: [Dog]) {
        let ids = dogs.map { $0.id }
        winnerIds.append(contentsOf: ids)
        save()
    }

    func load() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName),
              let data = try? Data(contentsOf: url),
              let ids = try? JSONDecoder().decode([UUID].self, from: data)
        else {
            self.winnerIds = []
            return
        }
        self.winnerIds = ids
    }

    private func save() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName),
              let data = try? JSONEncoder().encode(winnerIds)
        else { return }

        try? data.write(to: url)
    }
}

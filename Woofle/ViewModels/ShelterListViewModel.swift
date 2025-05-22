//
//  ShelterListViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import Foundation

final class ShelterListViewModel: ObservableObject {
    @Published var shelters: [ShelterViewModel] = []

    init() {
        let rawShelters: [Shelter] = JSONFileHelper.load(fileName: "shelters", fallback: [])
        self.shelters = rawShelters.map(ShelterViewModel.init)
    }

    func shelter(for id: UUID) -> ShelterViewModel? {
        shelters.first { $0.id == id }
    }
}

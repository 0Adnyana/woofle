//
//  ShelterListViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import Foundation

final class ShelterListViewModel: ObservableObject {
    @Published var shelters: [Shelter]

    init(shelters: [Shelter] = []) {
        self.shelters = shelters
    }
}


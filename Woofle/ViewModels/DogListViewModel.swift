//
//  DogListViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import Foundation

final class DogListViewModel: ObservableObject {
    @Published var dogs: [DogViewModel] = []

    init() {
        let rawDogs: [Dog] = JSONFileHelper.load(fileName: "dogs", fallback: [])
        self.dogs = rawDogs.map(DogViewModel.init)
    }
}

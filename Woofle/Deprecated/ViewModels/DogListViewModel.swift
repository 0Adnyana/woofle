//
//  DogListViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import Foundation

final class DogListViewModel: ObservableObject {
    @Published var dogs: [Dog]

    init(dogs: [Dog] = []) {
        self.dogs = dogs
    }
}

//
//  BreedValidator.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

struct BreedValidator {
    private static let validBreeds: [String] = {
        return BreedLoader.loadBreeds()
    }()

    static func isBreedValid(_ breed: String) -> Bool {
        validBreeds.contains(breed)
    }
}

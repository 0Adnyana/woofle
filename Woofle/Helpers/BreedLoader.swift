//
//  BreedLoader.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

struct BreedLoader {
    static func loadBreeds() -> [String] {
        guard let url = Bundle.main.url(forResource: "breeds", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let breeds = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return breeds
    }
}



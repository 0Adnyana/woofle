//
//  DynamicOptions.swift
//  Woofle
//
//  Created by Rahel on 22/05/25.
//

// DynamicOptions.swift

import Foundation

class DynamicOptions: ObservableObject {
    @Published var breeds: [String] = []
    @Published var sizes: [String] = []
    @Published var energyLevels: [String] = []
    @Published var personalityTraits: [String] = []
    @Published var genders: [String] = []
    @Published var specialNeedsOptions: [String] = []
    @Published var goodWithOptions: [String] = []

    init() {
        loadData()
    }

    private func load<T: Decodable>(_ filename: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            print("Failed to load \(filename).json")
            return nil
        }
        return decoded
    }

    func loadData() {
        breeds = load("breeds", type: [String].self) ?? []
        sizes = load("sizes", type: [String].self) ?? []
        energyLevels = load("energyLevels", type: [String].self) ?? []
        personalityTraits = load("personalityTraits", type: [String].self) ?? []
        genders = load("genders", type: [String].self) ?? []
        specialNeedsOptions = load("specialNeeds", type: [String].self) ?? []
        goodWithOptions = load("goodWith", type: [String].self) ?? []
    }
}


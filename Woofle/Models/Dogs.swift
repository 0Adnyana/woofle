//
//  Dogs.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

struct Dog: Identifiable, Codable {
    let id: UUID
    let name: String
    let gender: Gender
    let breed: String
    let ageInMonths: Int
    let shelterId: UUID
    let pictureURL: String
    let traits: DogTraits
    let createdAt: Date
}

struct DogTraits: Codable {
    let size: Size
    let energyLevel: EnergyLevel
    let personalityTags: [PersonalityTrait]
    let isVaccinated: Bool
    let isNeutered: Bool
    let isTrained: Bool
    let goodWithKids: Bool
    let goodWithOtherDogs: Bool
}


//
//  Traits.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

enum DogGender: String, Codable, CaseIterable {
    case male, female
}

enum HumanGender: String, Codable, CaseIterable {
    case male, female, other
}

enum Size: String, Codable, CaseIterable {
    case small, medium, large
}

enum EnergyLevel: String, Codable, CaseIterable {
    case low, moderate, high
}

enum PersonalityTrait: String, Codable, CaseIterable {
    case playful, calm, curious, affectionate, protective, independent
}

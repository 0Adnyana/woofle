//
//  Users.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

//struct UserProfile: Identifiable, Codable {
//    let id: UUID
//    let name: String
//    let gender: HumanGender
//    let age: Int
//    let location: GeoLocation
//    let preferences: UserPreferences
//}
//
//struct UserPreferences: Codable {
//    let preferredBreeds: [String]?
//    let sizePreferences: [Size]
//    let activityLevels: [EnergyLevel]
//    let goodWithKids: Bool?
//    let goodWithOtherDogs: Bool?
//    let personalityPreferences: [PersonalityTrait]
//    let preferredRadius: Double // in kilometers
//}

// MUTABLE STRUCTS

struct UserProfile: Identifiable, Codable {
    let id: UUID
    var name: String
    var gender: HumanGender
    var age: Int
    var location: GeoLocation
    var preferences: UserPreferences
}

struct UserPreferences: Codable {
    var preferredBreeds: [String]?
    var sizePreferences: [Size]
    var genderPreferences: [DogGender]
    var activityLevels: [EnergyLevel]
    var goodWithKids: Bool?
    var goodWithOtherDogs: Bool?
    var personalityPreferences: [PersonalityTrait]
    var preferredRadius: Double // in kilometers
}


extension UserProfile {
    static var fallbackUser = UserProfile(
        id: UUID(),
        name: "Fallback User",
        gender: .other,
        age: 25,
        location: GeoLocation(latitude: -8.67, longitude: 115.21),
        preferences: .default
    )
    
    static var empty: UserProfile {
        UserProfile(
            id: UUID(),
            name: "",
            gender: .other,
            age: 0,
            location: GeoLocation(latitude: 0, longitude: 0),
            preferences: .default
        )
    }
}

extension UserPreferences {
    static var `default`: UserPreferences {
        UserPreferences(
            preferredBreeds: nil,
            sizePreferences: [.medium],
            genderPreferences: [.female, .male],
            activityLevels: [.moderate],
            goodWithKids: false,
            goodWithOtherDogs: nil,
            personalityPreferences: [.playful],
            preferredRadius: 50
        )
    }
}

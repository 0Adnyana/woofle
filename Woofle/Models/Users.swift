//
//  Users.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

struct UserProfile: Identifiable, Codable {
    let id: UUID
    let name: String
    let gender: HumanGender
    let age: Int
    let location: GeoLocation
    let preferences: UserPreferences
}

struct UserPreferences: Codable {
    let preferredBreeds: [String]?
    let sizePreferences: [Size]
    let activityLevels: [EnergyLevel]
    let goodWithKids: Bool?
    let goodWithOtherDogs: Bool?
    let personalityPreferences: [PersonalityTrait]
    let preferredRadius: Double // in kilometers
}

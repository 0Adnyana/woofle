//
//  DummyData.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 24/05/25.
//

import Foundation

let userFallback = UserProfile(
    id: UUID(),
    name: "Fallback User",
    gender: .other,
    age: 25,
    location: GeoLocation(latitude: -8.67, longitude: 115.21),
    preferences: .init(
        preferredBreeds: nil,
        sizePreferences: [.medium],
        activityLevels: [.moderate],
        goodWithKids: false,
        goodWithOtherDogs: nil,
        personalityPreferences: [.playful],
        preferredRadius: 30
    )
)

struct DummyData {
    static let dogs: [Dog] = JSONFileHelper.load(fileName: "dogs", fallback: [])
    static let user: UserProfile = JSONFileHelper.load(fileName: "user", fallback: userFallback)
    static let shelters: [Shelter] = JSONFileHelper.load(fileName: "shelters", fallback: [])
    static let breeds: [String] = JSONFileHelper.load(fileName: "breeds", fallback: [])
    static let pastWinnerIds: [UUID] = JSONFileHelper.load(fileName: "past_winners", fallback: [])
}

//
//  UserViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published var user: UserProfile {
        didSet {
            JSONFileHelper.save(user, to: "user.json")
        }
    }

    init() {
        let fallback = UserProfile(
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
        self.user = JSONFileHelper.load(fileName: "user", fallback: fallback)
    }

    func update(_ updated: UserProfile) {
        self.user = updated
    }
}

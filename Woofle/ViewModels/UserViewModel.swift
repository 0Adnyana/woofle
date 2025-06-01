//
//  UserViewModel.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 01/06/25.
//

import Foundation
import SwiftUI

final class UserViewModel: ObservableObject {
    @Published var user: UserProfile
    @AppStorage("isUserOnboarded") var isUserOnboarded: Bool = false

    private let userService = UserStorageService()

    init() {
        if let existing = userService.load() {
            user = existing
        } else {
            user = .empty
        }
    }

    func completeOnboarding() {
        save()
        isUserOnboarded = true
    }

    func updateName(_ name: String) {
        user.name = name
        save()
    }

    func updatePreferences(_ prefs: UserPreferences) {
        user.preferences = prefs
        save()
    }

    func updateLocation(_ location: GeoLocation) {
        user.location = location
        save()
    }

    private func save() {
        userService.save(user)
    }
}

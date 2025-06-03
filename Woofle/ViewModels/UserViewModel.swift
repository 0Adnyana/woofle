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
        print(isUserOnboarded)
    }

    func completeOnboarding() {
        save()
        isUserOnboarded = true
    }

    func updateName(_ name: String) {
        user.name = name
        save()
    }
    
    func updateBirthYear(_ yearString: String) {
        guard let year = Int(yearString) else {
            return
        }
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        let age = max(currentYear - year, 0)
        
        user.age = age
        save()
    }
    
    func updateGender(_ gender: HumanGender) {
        user.gender = gender
        save()
    }
    
    func updateLocation(_ location: GeoLocation) {
        user.location = location
        save()
    }

    func updateSizePreferences(_ sizePreferences: [Size]) {
        user.preferences.sizePreferences = sizePreferences
        save()
    }
    
    func updateGenderPreferences(_ genderPreferences: [DogGender]) {
        user.preferences.genderPreferences = genderPreferences
        save()
    }
    
    func updateActivityLevels(_ activityLevels: [EnergyLevel]) {
        user.preferences.activityLevels = activityLevels
        save()
    }
    
    func updatePersonalityPreferences(_ personalityPreferences: [PersonalityTrait]) {
        user.preferences.personalityPreferences = personalityPreferences
        save()
    }
    
    func updateBreedPreferences(_ breedPreferences: [String]) {
        user.preferences.preferredBreeds = breedPreferences
        save()
    }
    
    func updateGoodWithKids(_ goodWithKids: Bool) {
        user.preferences.goodWithKids = goodWithKids
        save()
    }
    
    func updateGoodWithOtherDogs(_ goodWithOtherDogs: Bool) {
        user.preferences.goodWithOtherDogs = goodWithOtherDogs
        save()
    }
    
    func updateUserPreferences(_ userPreferences: UserPreferences) {
        user.preferences = userPreferences
        save()
    }
    
    func updateUserProfile(_ updatedUserProfile: UserProfile) {
        user = updatedUserProfile
        save()
    }
    
    func resetAllUserData() {
        user = .empty
        isUserOnboarded = false
        userService.save(user)

        let pastWinnersService = PastWinnersStorageService()
        pastWinnersService.deleteAll()

        print("🔁 All user data has been reset.")
    }


    private func save() {
        userService.save(user)
    }
    


}

////
////  OnboardingViewModel.swift
////  Woofle
////
////  Created by I Made Bayu Putra Adnyana on 01/06/25.
////
//
//import Foundation
//
//final class OnboardingViewModel: ObservableObject {
//    @Published var isUserOnboarded: Bool = false
//    @Published var tempUser: UserProfile
//
//    private let userService = UserStorageService()
//
//    init() {
//        if let existingUser = userService.load() {
//            isUserOnboarded = true
//            tempUser = existingUser // load just in case
//        } else {
//            isUserOnboarded = false
//            tempUser = .empty // default empty user
//        }
//    }
//
//    func completeOnboarding() {
//        userService.save(tempUser)
//        isUserOnboarded = true
//    }
//
//    func updateName(_ name: String) {
//        tempUser.name = name
//    }
//
//    func updatePreferences(_ preferences: UserPreferences) {
//        tempUser.preferences = preferences
//    }
//
//    func updateLocation(_ location: GeoLocation) {
//        tempUser.location = location
//    }
//
//    // Add more update funcs as needed
//}

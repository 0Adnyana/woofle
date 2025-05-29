//
//  AppStateViewModel.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 29/05/25.
//

import Foundation

final class AppStateViewModel: ObservableObject {
    @Published var isUserOnboarded: Bool = false
    
    private let userService = UserStorageService()
    
    init() {
        isUserOnboarded = userService.load() != nil
    }
    
    func completeOnboading(user: UserProfile) {
        userService.save(user)
        isUserOnboarded = true
    }
}

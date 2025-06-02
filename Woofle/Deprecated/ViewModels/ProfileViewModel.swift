////
////  ProfileViewModel.swift
////  Woofle
////
////  Created by I Made Bayu Putra Adnyana on 01/06/25.
////
//
//import Foundation
//
//final class ProfileViewModel: ObservableObject {
//    @Published var user: UserProfile
//    private let userService = UserStorageService()
//    
//    init() {
//        self.user = userService.load() ?? UserProfile.fallbackUser
//    }
//    
//    func updateName(_ name: String) {
//        user.name = name
//        save()
//    }
//    
//    private func save() {
//        userService.save(user)
//    }
//}

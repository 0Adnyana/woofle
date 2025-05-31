//
//  WoofleApp.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import SwiftUI


@main
struct WoofleApp: App {
    @StateObject private var userViewModel = UserViewModel()
    var body: some Scene {
        WindowGroup {
            WelcomeView()
            .environmentObject(userViewModel)
        }
    }
}

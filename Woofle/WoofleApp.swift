//
//  WoofleApp.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import SwiftUI


@main
struct WoofleApp: App {
    var body: some Scene {
        WindowGroup {
            WinnerDogListView(
                pastWinnersVM: {
                    let vm = PastWinnersViewModel()
                    vm.winnerIds = [DummyData.dogs.first!.id]
                    return vm
                }(),
                dogListVM: DogListViewModel(dogs: DummyData.dogs),
                shelterListVM: ShelterListViewModel(shelters: DummyData.shelters)
            )
            //StartView()
        }
    }
}

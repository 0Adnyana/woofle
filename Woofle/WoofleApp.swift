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
            StartView()
        }
    }
}

//UNCOMMENT THIS to test WinnerDogCard
/*
@main
struct WoofleApp: App {
    var body: some Scene {
        WindowGroup {
            WinnerDogCard(dog: getFirstThreeDogList()[0], shelter: getFirstShelter())
        }
    }
    
    func getFirstThreeDogList() -> [Dog] {
        let dogListViewModel = DogListViewModel()
        var topThreeDogList = [Dog]()
        
        for i in 1 ... 3 {
            topThreeDogList.append(dogListViewModel.dogs[i].dog)
        }
        
        return topThreeDogList
    }
    
    func getShelterList() -> [Shelter] {
        return ShelterListViewModel().shelters.map { $0.shelter }
    }
}
*/

//UNCOMMENT THIS to test Map with dummy data
/*
@main
struct WoofleApp: App {
    var body: some Scene {
        WindowGroup {
            WinnerDogsMapView(shelterList: getShelterList(), winnerDogList: getFirstThreeDogList())
        }
    }
    
    func getFirstThreeDogList() -> [Dog] {
        let dogListViewModel = DogListViewModel()
        var topThreeDogList = [Dog]()
        
        for i in 1 ... 3 {
            topThreeDogList.append(dogListViewModel.dogs[i].dog)
        }
        
        return topThreeDogList
    }
    
    func getShelterList() -> [Shelter] {
        return ShelterListViewModel().shelters.map { $0.shelter }
    }
}
*/



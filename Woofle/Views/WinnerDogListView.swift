//
//  WinnerDogListView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 27/05/25.
//

import SwiftUI

struct WinnerDogListView: View {
    //private let winnerDogList: [DogWithShelter]
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(getWinnerDogList()) { winnerDog in
                    Text(winnerDog.id.uuidString)
                    
                    //WinnerDogCard(dog: winnerDog.dog, shelter: winnerDog.shelter)
                }
            }
        }

    }
    
    //Get List of Winner Dog
//    func getWinnerDogList() -> [DogWithShelter] {
//        let pastWinnerList = PastWinnersViewModel()
//        let dogList = DogListViewModel()
//        let shelterList = ShelterListViewModel()
//        
//        let dogWithShelterList: [DogWithShelter] = pastWinnerList.winnerIds.compactMap { pastWinnerDog in
//            guard let dogId = UUID(uuidString: pastWinnerDog.uuidString),
//                  let dog = dogList.first(where: { $0.id == dogId }),
//                  let shelter = shelterList.first(where: { $0.id == dog.shelterId }) else {
//                return nil
//            }
//            return DogWithShelter(dog: dog, shelter: shelter)
//        }
//        
//        return dogWithShelterList
//        
//    }
}

//#Preview {
//    WinnerDogListView()
//}

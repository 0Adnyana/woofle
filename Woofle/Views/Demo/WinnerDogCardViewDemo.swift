//
//  WinnerDogCardView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 27/05/25.
//

import SwiftUI

struct WinnerDogCardViewDemo: View {
    var body: some View {
       
        WinnerDogCard(dog: getFirstThreeDogList()[0], shelter: getFirstShelter())
        
    }
    
    private func getFirstThreeDogList() -> [Dog] {
        let dogListViewModel = DogListViewModel()
        var topThreeDogList = [Dog]()
        
        for i in 1 ... 3 {
            topThreeDogList.append(dogListViewModel.dogs[i])
        }
        
        return topThreeDogList
    }
    
    private func getShelterList() -> [Shelter] {
        return ShelterListViewModel().shelters.map { $0 }
    }
}

#Preview {
    WinnerDogCardViewDemo()
}

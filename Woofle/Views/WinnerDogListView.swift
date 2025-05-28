//
//  WinnerDogListView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 27/05/25.

import SwiftUI

struct WinnerDogListView: View {
    @ObservedObject var pastWinnersVM: PastWinnersViewModel
    @ObservedObject var dogListVM: DogListViewModel
    @ObservedObject var shelterListVM: ShelterListViewModel

    var body: some View {
        ScrollView {
            VStack {
                ForEach(getWinnerDogList(), id: \.dog.id) { winnerDog in
                    Text(winnerDog.id.uuidString)
                    WinnerDogCard(dog: winnerDog.dog, shelter: winnerDog.shelter)
                }
            }
        }
    }

    func getWinnerDogList() -> [DogWithShelter] {
        pastWinnersVM.winnerIds.compactMap { id in
            guard let dog = dogListVM.dogs.first(where: { $0.id == id }),
                  let shelter = shelterListVM.shelters.first(where: { $0.id == dog.shelterId }) else {
                return nil
            }
            return DogWithShelter(dog: dog, shelter: shelter)
        }
    }
}


#Preview {
    WinnerDogListView(
        pastWinnersVM: {
            let vm = PastWinnersViewModel()
            vm.winnerIds = [DummyData.dogs.first!.id]
            return vm
        }(),
        dogListVM: DogListViewModel(dogs: DummyData.dogs),
        shelterListVM: ShelterListViewModel(shelters: DummyData.shelters)
    )
}


//
//  WinnerDogListView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 27/05/25.

import SwiftUI

struct WinnerDogListView: View {
    private var winnerDogList: [Dog] = [Dog]()
    private var winnerDogWithShelter: [DogWithShelter] = [DogWithShelter]()
    private var shelterList: [Shelter] = [Shelter]()
    
    init() {
        var addedShelterId = Set<UUID>()
        
        self.winnerDogWithShelter = getWinnerDogList()
        
        if !self.winnerDogWithShelter.isEmpty {
            self.winnerDogList = self.winnerDogWithShelter.map { $0.dog }
            
            let uniqueShelterList = self.winnerDogWithShelter.filter { addedShelterId.insert($0.id).inserted }
            
            self.shelterList = uniqueShelterList.map { $0.shelter }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("History")
                    .font(.title) // Customize size
                    .fontWeight(.bold) // Customize weight
                    .foregroundColor(.primary) // Customize color
                Spacer() // Push title to the left
                NavigationLink(
                    destination: WinnerDogsMapView(
                        shelterList: shelterList,
                        winnerDogList: winnerDogList
                    )
                ) {
                    Image("MapIcon")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(winnerDogWithShelter, id: \.dog.id) { winnerDog in
                        WinnerDogCard(dog: winnerDog.dog, shelter: winnerDog.shelter)
                    }
                }
                .padding()
            }
            /*.navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("History")
                            .font(.title) // Customize size
                            .fontWeight(.bold) // Customize weight
                            .foregroundColor(.primary) // Customize color
                        Spacer() // Push title to the left
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: WinnerDogsMapView(
                            shelterList: shelterList,
                            winnerDogList: winnerDogList
                        )
                    ) {
                        Image("MapIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                
            }*/
        }
    }

    func getWinnerDogList() -> [DogWithShelter] {
        let pastWinnersList: [UUID] = DummyData.pastWinnerIds
        let dogList: [Dog] = DummyData.dogs
        let shelterList: [Shelter] = DummyData.shelters
        
        return pastWinnersList.compactMap { id in
            guard let dog = dogList.first(where: { $0.id == id }),
                  let shelter = shelterList.first(where: { $0.id == dog.shelterId }) else {
                return nil
            }
            return DogWithShelter(dog: dog, shelter: shelter)
        }
    }
}


#Preview {
    WinnerDogListView()
}


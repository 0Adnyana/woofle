//
//  CongratulationsView.swift
//  Woofle
//
//  Created by Jesse Brown on 31/5/2025.
//

import SwiftUI

struct CongratulationsView: View {
    let dog: Dog
    let shelter: Shelter

    @State private var goToTabBarView = false
    
    var body: some View {
        ZStack {
            VStack {
                if let frames = extractFramesFromGIF(named: "Confetti") {
                    FrameAnimator(frames: frames)
                        .frame(width: 350)
                        .padding()
                }
                
                Spacer()
            }
            
            VStack(spacing: 40) {
                // Title
                VStack(alignment: .leading, spacing: 40) {
                    Text("And the winner is…")
                        .font(.title2)
                        .bold()
                    
                    Text(dog.name.capitalized)
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
<<<<<<< HEAD
                
                // Dog card (info button works via DogCard)
                DogCard(dog: dog, shelter: shelter, onSelect: {})
                
                // Description
                Text("\(dog.name.capitalized) can be your new furry friend, contact the shelter by clicking the info button to meet up!")
                    .font(.body)
                    .foregroundColor(Color(hex: "999999"))
                    .padding(.horizontal)
                
                Button(action: {
                    goToTabBarView = true
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "dog.circle")
                            .font(.system(size: 32))
                            .foregroundColor(Color(hex: "B67A4B"))
                        Text("Home")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .fontWeight(.medium)
                    }
=======

            // Home Button
            NavigationLink {
                TabBarView()
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 32))
                        .foregroundColor(Color(hex: "000000"))
                    Text("Home")
                        .font(.caption)
                        .foregroundColor(Color(hex: "000000"))
>>>>>>> main
                }
                .fullScreenCover(isPresented: $goToTabBarView) {
                    TabBarView()
                }
                
                // Home Button
                /*NavigationLink {
                 StartTournamentView()
                 } label: {
                 VStack(spacing: 4) {
                 Image(systemName: "house.fill")
                 .font(.system(size: 32))
                 .foregroundColor(Color(hex: "000000"))
                 Text("Home")
                 .font(.caption)
                 .foregroundColor(Color(hex: "000000"))
                 }
                 }
                 .padding(.top, 20)*/
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 60)
            
        }
        .onAppear {
            playCelebrationSound()
        }
        .navigationBarBackButtonHidden()
    }
    
    func playCelebrationSound() {
        SoundPlayer.shared.playSounds(soundNames: ["moreClaps", "smallDogBarking"])
    }
}

#Preview {
    if let winnerID = DummyData.pastWinnerIds.first,
       let winnerDog = DummyData.dogs.first(where: { $0.id == winnerID }),
       let shelter = DummyData.shelters.first(where: { $0.id == winnerDog.shelterId }) {
        CongratulationsView(dog: winnerDog, shelter: shelter)
    } else {
        Text("Missing test data")
    }
}

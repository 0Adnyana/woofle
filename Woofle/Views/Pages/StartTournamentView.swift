//
//  HomePageStartTournament.swift
//  Woofle
//
//  Created by Rahel on 22/05/25.
//

import SwiftUI

struct StartTournamentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                // Center content
                Text("Find your perfect dog")
                    .font(.title)
                    .padding(.bottom, 20)
                NavigationLink{
                    HomeViewDemo()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "DFE4D6"))
                            .frame(width: 210, height: 210)
                        Image("PawPrint")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 255, height: 255)
                    }
                }
                
                HStack {
                    Spacer()
                    if let frames = extractFramesFromGIF(named: "Shiba Inu") {
                        FrameAnimator(frames: frames)
                            .frame(width: 150)
                            .padding()
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Woofle")
                            .font(.title) // Customize size
                            .fontWeight(.bold) // Customize weight
                            .foregroundColor(.primary) // Customize color
                        Spacer() // Push title to the left
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: ProfileView()
                    ) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(hex: "A3B18A"))
                    }
                }

            }
        }
    }
}

#Preview {
    StartTournamentView()
        .environmentObject(UserViewModel()) // Inject the required environment object
}

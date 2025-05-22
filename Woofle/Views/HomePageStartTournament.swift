//
//  HomePageStartTournament.swift
//  Woofle
//
//  Created by Rahel on 22/05/25.
//

import SwiftUI

struct HomePageStartTournament: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Top bar
                    HStack {
                        Text("Woofle")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Center content
                    Text("Find your perfect dog")
                        .font(.headline)
                        .padding(.bottom, 20)
                    NavigationLink{
                        TournamentView()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.2))
                                .frame(width: 200, height: 200)
                            Circle()
                                .fill(Color.green.opacity(0.3))
                                .frame(width: 170, height: 170)
                            Image(systemName: "pawprint.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.green.opacity(0.6))
                        }
                    }
                    
                    Spacer()
                    
                    // Bottom Tab Bar
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "dog.circle")
                                .foregroundColor(.brown)
                            Text("Tournament")
                                .font(.caption)
                                .foregroundColor(.brown)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                            Text("History")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.purple.opacity(0.3)),
                        alignment: .top
                    )
                }
            }
        }
    }
}

#Preview {
    HomePageStartTournament()
}

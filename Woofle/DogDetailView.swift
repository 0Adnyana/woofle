//
//  DogDetailView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 21/05/25.
//

import Foundation
import SwiftUI
import MapKit

struct DogDetailView: View {
    let dog: Dog
    let shelter: Shelter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Dog image
                Image(dog.pictureURL)
                    .resizable()
                    .frame(height: 250)
                    .aspectRatio(contentMode: .fill)
                
                // Dog info
                VStack(alignment: .leading, spacing: 8) {
                    Text(dog.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("\(dog.ageInMonths / 12 > 0 ? "\(abs(dog.ageInMonths / 12)) Years \(dog.ageInMonths % 12) Month" : "\(dog.ageInMonths % 12) Month") Years 􀾟 \(dog.gender)")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("􂀇 \(dog.breed)")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("􀠸 \(dog.traits.isVaccinated ? "Vaccinated" : "Not Vaccinated" )")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("􀯚 \(dog.traits.isNeutered ? "Neutered" : "Not Yet Neutered")")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    // Personality tags
                    if !dog.traits.personalityTags.isEmpty {
                        Text("Personality:")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(dog.traits.personalityTags, id: \.self) { trait in
                                    Text(trait.rawValue)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color.init(hex: "A3B18A").opacity(0.2))
                                        .cornerRadius(15)
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Additional details
                    VStack(alignment: .leading, spacing: 8) {
                        switch dog.traits.energyLevel {
                        case .low:
                            DogDetailRowView(icon: "bolt.fill",
                                          text: "Energy level: \(String(repeating: "⚡️", count: 1))")
                        case .moderate:
                            DogDetailRowView(icon: "bolt.fill",
                                          text: "Energy level: \(String(repeating: "⚡️", count: 3))")
                        case .high:
                            DogDetailRowView(icon: "bolt.fill",
                                          text: "Energy level: \(String(repeating: "⚡️", count: 5))")
                        }
                        
                        DogDetailRowView(icon: "ruler.fill",
                                         text: "Size: \(dog.traits.size)")
                        
                        //TODO: Need to add Shelter Name
                        DogDetailRowView(icon: "house.fill",
                                         text: "Location: \(shelter.name)")
                    }
                    
                    Spacer()
                    
                    // Action buttons
                    HStack {
                        // TODO: Change Button color
                        Button(action: {
                            // Action for contact
                        }) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Contact")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        //TODO: Feature later for adding as favourites
                        /*Button(action: {
                            // Action for favorites
                        }) {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("Favorite")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)*/
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}


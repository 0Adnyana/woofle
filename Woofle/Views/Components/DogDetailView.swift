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
    
    var onGetDirections: () -> Void
    
    func callNumber(_ number: String) {
        if let url = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Cannot make a call.")
        }
    }
    
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
                    
                    HStack {
                        Text("\(getYearsfromMonth(for: dog.ageInMonths))")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Image(systemName: "pawprint.fill")
                            .foregroundColor(Color(hex: "A3B18A"))
                            .frame(width: 25)
                        Text("\(dog.gender.rawValue.capitalized)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                        
                    DogDetailRowView(icon: "dog.fill", text: dog.breed)
                    DogDetailRowView(icon: "syringe.fill", text: dog.traits.isVaccinated ? "Vaccinated" : "Not Vaccinated")
                    DogDetailRowView(icon: "cross.case.fill", text: dog.traits.isNeutered ? "Neutered" : "Not Neutered")
                    
                    Divider()
                    
                    // Personality tags
                    if !dog.traits.personalityTags.isEmpty {
                        Text("Personality:")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(dog.traits.personalityTags, id: \.self) { trait in
                                    Text(trait.rawValue.capitalized)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .foregroundColor(.black)
                                        .background(Color.init(hex: "D8E6BF"))
                                        .cornerRadius(15)
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Additional details
                    VStack(alignment: .leading, spacing: 10) {
                        DogDetailRowView(icon: "bolt.fill",
                                         text: "Energy level: \(dog.traits.energyLevel.rawValue.capitalized)")
                        DogDetailRowView(icon: "ruler.fill",
                                         text: "Size: \(dog.traits.size.rawValue.capitalized)")
                        DogDetailRowView(icon: "house.fill",
                                         text: "Location: \(shelter.name)")
                    }
                    
                    Spacer()
                    
                    // Action buttons
                    HStack {
                        Button(action: {
                            callNumber(shelter.phoneNumber)
                        }) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Contact")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(Color.white)
                        .tint(Color.init(hex: "A3B18A").opacity(1))
                        .cornerRadius(15)
                        
                        //Feature to get direction
                        Button(action: onGetDirections) {
                            HStack {
                                Image(systemName: "arrow.turn.left.up")
                                Text("Get Direction")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(Color.white)
                        .tint(Color.init(hex: "A3B18A").opacity(1))
                        .cornerRadius(15)
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        
        
        //Other Version to disable ScrollView but didn't seem to work
        //And the image of the dog can be displayed in full width and not in the center
        /*GeometryReader { geometry in
            AdaptiveContentView(height: geometry.size.height) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(dog.pictureURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(dog.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        HStack {
                            Text(getYearsfromMonth(for: dog.ageInMonths))
                                .font(.title2)
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "pawprint.fill")
                                .foregroundColor(Color(hex: "A3B18A"))
                            
                            Text(dog.gender.rawValue.capitalized)
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                        
                        DogDetailRowView(icon: "dog.fill", text: dog.breed)
                        DogDetailRowView(icon: "syringe.fill", text: dog.traits.isVaccinated ? "Vaccinated" : "Not Vaccinated")
                        DogDetailRowView(icon: "cross.case.fill", text: dog.traits.isNeutered ? "Neutered" : "Not Neutered")
                        
                        if !dog.traits.personalityTags.isEmpty {
                            Text("Personality:")
                                .font(.headline)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(dog.traits.personalityTags, id: \.self) { trait in
                                        Text(trait.rawValue.capitalized)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .foregroundColor(.black)
                                            .background(Color(hex: "D8E6BF"))
                                            .cornerRadius(15)
                                    }
                                }
                            }
                        }
                        
                        DogDetailRowView(icon: "bolt.fill", text: "Energy level: \(dog.traits.energyLevel.rawValue.capitalized)")
                        DogDetailRowView(icon: "ruler.fill", text: "Size: \(dog.traits.size.rawValue.capitalized)")
                        DogDetailRowView(icon: "house.fill", text: "Location: \(shelter.name)")
                    }
                    
                    //Spacer(minLength: 20)
                    
                    HStack {
                        Button(action: {
                            callNumber(shelter.phoneNumber)
                        }) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Contact")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .tint(Color(hex: "A3B18A"))
                        .cornerRadius(15)
                        
                        Button(action: onGetDirections) {
                            HStack {
                                Image(systemName: "arrow.turn.left.up")
                                Text("Get Direction")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .tint(Color(hex: "A3B18A"))
                        .cornerRadius(15)
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)*/
         
    }
    
}


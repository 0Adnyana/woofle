//
//  DogCard.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 23/05/25.
//

import SwiftUI

struct WinnerDogCard: View {
    let dog: Dog
    let shelter: Shelter
    
    @State private var showDetails = false
    @State private var showDirectionsOptions = false
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 100)
                .background(
                    Image(dog.pictureURL)
                        .resizable()
                        .clipShape(.circle)
                        .aspectRatio(contentMode: .fill)                      .clipped()
                )
                .overlay(
                    Circle()
                        .inset(by: -1.5)
                        .stroke(Color(red: 0.64, green: 0.69, blue: 0.54).opacity(0.8), lineWidth: 4)
                )
                .padding()
            
            VStack(alignment: .leading) {
                Text(dog.name.capitalized)
                    .font(.title)
                    .bold()
                Text(getYearsfromMonth(for: dog.ageInMonths))
                Text(dog.gender.rawValue.capitalized)
                
                // Personality tags
                if !dog.traits.personalityTags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 5) {
                            ForEach(dog.traits.personalityTags, id: \.self) { trait in
                                Text(trait.rawValue.capitalized)
                                    .font(.callout)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.black)
                                    .background(Color.init(hex: "D8E6BF").opacity(0.8))
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.64, green: 0.69, blue: 0.54), lineWidth: 1
                                                   )

                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(.vertical, 15)
        }
        .background(Color(hex: "F8CE9B").opacity(0.35))
        .cornerRadius(15)
        .onTapGesture {
            showDetails.toggle()
        }
        .sheet(isPresented: $showDetails) {
            DogDetailView(dog: dog, shelter: shelter) {
                showDirectionsOptions = true
            }
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .presentationCornerRadius(25)
        }
        .alert("Get Directions", isPresented: $showDirectionsOptions, presenting: shelter) { shelter in
            // Apple Maps button
            Button("Apple Maps") {
                openMapsWithAppleMaps(shelter: shelter)
            }
            
            // Google Maps button (only shown if installed)
            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                Button("Google Maps") {
                    openMapsWithGoogleMaps(shelter: shelter)
                }
            }
            
            Button("Cancel", role: .cancel) { }
        } message: { location in
            Text("How would you like to get directions to \(location.name)?")
        }
    }
}

#Preview {
    WinnerDogCard(dog: getFirstThreeDogList()[0], shelter: getFirstShelter())
}

func getFirstShelter() -> Shelter {
    let shelterListViewModel = ShelterListViewModel()
    let shelterList = shelterListViewModel.shelters
    
    return shelterList[0]
}

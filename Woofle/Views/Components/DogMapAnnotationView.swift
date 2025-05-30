//
//  DogMapAnnotationView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 21/05/25.
//

import Foundation
import SwiftUI
import MapKit

// Custom Map Annotation View
struct DogMapAnnotationView: View {
    let dogList: [Dog]
    let shelter: Shelter
    @State private var showDetails = false
    @State private var showDirectionsOptions = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom dog icon
            ZStack {
                Image("DogPinPoint")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 43, height: 33)
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                
                if dogList.count > 1 {
                    Circle()
                        .fill(.white)
                        .frame(width: 25, height: 25)
                        .offset(x: 20, y: -17)
                    
                
                    Text("\(dogList.count)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .offset(x: 20, y: -17)
                    
                }
            }
            .scaleEffect(showDetails ? 1.2 : 1.0)
            .animation(.spring(), value: showDetails)
            
            // Dog name label
            if dogList.count == 1 {
                Text(dogList[0].name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(4)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(4)
                    .shadow(radius: 2)
                    .foregroundColor(.black)
            } 
        }
        .onTapGesture {
            showDetails.toggle()
        }
        .sheet(isPresented: $showDetails) {
            CustomPageTabView(
                items: dogList,
                content: { dog in
                    DogDetailView(dog: dog, shelter: shelter) {
                        showDirectionsOptions = true
                    }
                },
                currentPageTintColor: UIColor(Color(hex: "9E5922")),
                pageIndicatorTintColor: .lightGray
            )
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

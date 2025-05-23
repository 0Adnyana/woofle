//
//  WinnerDogsMapView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 21/05/25.
//

import Foundation
import SwiftUI
import MapKit

// Main Map View with iOS 17+ compatible API
struct WinnerDogsMapView: View {
    var shelterList: [Shelter]
    var winnerDogList: [Dog]
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var locationManager = CLLocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        Map(
            initialPosition: cameraPosition, //.region(region),
            interactionModes: .all
        ) {
            // User location if available
            UserAnnotation()
            
            // Dog annotations
            ForEach(getDogWithOwner()) { dogWithOwner in
                Annotation("", coordinate: dogWithOwner.shelter.location.coordinate) {
                    DogMapAnnotationView(dog: dogWithOwner.dog, shelter: dogWithOwner.shelter)
                }
            }
        }
        .mapControls {
            // Add map controls
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
    
    func getDogWithOwner() -> [DogWithShelter] {
        winnerDogList.map { dog in
            if let shelter = shelterList.first(where: { $0.id == dog.shelterId }) {
                return DogWithShelter(dog: dog, shelter: shelter)
            } else {
                return DogWithShelter(dog: dog, shelter: try! Shelter(from: "" as! Decoder))
            }
        }
    }

}

#Preview {
    WinnerDogsMapView(shelterList: getShelterList(), winnerDogList: getFirstThreeDogList())
}

func getFirstThreeDogList() -> [Dog] {
    let dogListViewModel = DogListViewModel()
    var topThreeDogList = [Dog]()
    
    for i in 1 ... 3 {
        topThreeDogList.append(dogListViewModel.dogs[i].dog)
    }
    
    return topThreeDogList
}

func getShelterList() -> [Shelter] {
    return ShelterListViewModel().shelters.map { $0.shelter }
}

/*import SwiftUI
import MapKit
import CoreLocation

struct WinnerDogsMapView: View {
    // Map camera position (iOS 17+)
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // Location manager to request permission
    @State private var locationManager = CLLocationManager()
    
    // Track if we have location permission
    @State private var hasLocationPermission = false
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                if hasLocationPermission {
                    UserAnnotation()
                }
            }
                
            
                /*Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [location]) { location in
                    MapMarker(coordinate: location.coordinate, tint: .blue)
                }
                .frame(height: 300)
                .onAppear {
                    region.center = location.coordinate
                }*/
                
                /*Map(
                    initialPosition: .region(region),
                    interactionModes: .all
                ) {
                    // User location if available
                    UserAnnotation()
                    
                    // Dog annotations
                    /*ForEach(dogLocations) { location in
                     Annotation(location.dog.name, coordinate: location.coordinate) {
                     DogMapAnnotationView(dog: location.dog)
                     }
                     }*/
                }
                //.mapStyle(.hybrid(elevation: .flat))
                .mapControls {
                    // Add map controls
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                .overlay(alignment: .topTrailing) {
                    // Custom filter buttons
                    /*VStack {
                     Button(action: filterFeaturedDogs) {
                     Image(systemName: "crown.fill")
                     .padding()
                     .background(Color.white)
                     .clipShape(Circle())
                     .shadow(radius: 3)
                     }
                     
                     Button(action: centerOnUserLocation) {
                     Image(systemName: "location.fill")
                     .padding()
                     .background(Color.white)
                     .clipShape(Circle())
                     .shadow(radius: 3)
                     }
                     }
                     .padding()*/
                }*/
            
        }
        .navigationBarBackButtonHidden(false)
    }
}*/



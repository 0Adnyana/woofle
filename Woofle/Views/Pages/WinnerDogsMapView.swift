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
    
    @State private var selectedShelter: Shelter?
    @State private var showDirectionsOptions = false
    
    var body: some View {
        Map(
            initialPosition: cameraPosition, //.region(region),
            interactionModes: .all
        ) {
            // User location if available
            UserAnnotation()
            
            // Dog annotations
            ForEach(getDogWithShelter()) { dogWithShelter in
                Annotation("", coordinate: dogWithShelter.shelter.location.coordinate) {
                    DogMapAnnotationView(dog: dogWithShelter.dog, shelter: dogWithShelter.shelter)
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
    
    func getDogWithShelter() -> [DogWithShelter] {
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
        topThreeDogList.append(dogListViewModel.dogs[i])
    }
    
    return topThreeDogList
}

func getShelterList() -> [Shelter] {
    return ShelterListViewModel().shelters
}



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
            
            ForEach(shelterList) { shelter in
                Annotation("", coordinate: shelter.location.coordinate) {
                    DogMapAnnotationView(dogList: getDogList(shelterId: shelter.id), shelter: shelter)
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
    
    func getDogList(shelterId: UUID) -> [Dog] {
        return winnerDogList.compactMap { winnerDog in
            guard winnerDog.shelterId == shelterId else {
                return nil
            }
            return winnerDog
        }
    }

}

#Preview {
    WinnerDogsMapView(shelterList: DummyData.shelters, winnerDogList: DummyData.dogs)
}



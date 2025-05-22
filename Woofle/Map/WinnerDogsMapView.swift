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
    @State private var locationManager = CLLocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        Map(
            initialPosition: .region(region),
            interactionModes: .all
        ) {
            // User location if available
            UserAnnotation()
            
            // Dog annotations
            ForEach(dogLocations) { location in
                Annotation(location.dog.name, coordinate: location.coordinate) {
                    DogMapAnnotationView(dog: location.dog)
                }
            }
        }
        //.mapStyle(.hybrid(elevation: .flat))
        .mapControls {
            // Add map controls
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }

}

#Preview {
    WinnerDogsMapView()
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



//
//  LocationManager.swift
//  Woofle_App_CH2
//
//  Created by Rahel on 20/05/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentLocation: String = "Unknown"
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var lastKnownCoordinate: CLLocationCoordinate2D?

    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        authorizationStatus = locationManager.authorizationStatus
        locationManager.startUpdatingLocation()
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        lastKnownCoordinate = location.coordinate

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            if let place = placemarks?.first {
                DispatchQueue.main.async {
                    self.currentLocation = [place.locality, place.country].compactMap { $0 }.joined(separator: ", ")
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

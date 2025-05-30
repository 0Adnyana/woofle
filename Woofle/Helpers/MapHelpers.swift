//
//  MapHelpers.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 25/05/25.
//

import Foundation
import MapKit
import CoreLocation

//Open with Apple Maps
func openMapsWithAppleMaps(shelter: Shelter) {
    let placemark = MKPlacemark(coordinate: shelter.location.coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = shelter.name
    
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    mapItem.openInMaps(launchOptions: launchOptions)
}

//Open with Google Maps
//Add info.plist
//key: LSApplicationQueriesSchemes
//value: comgooglemaps
func openMapsWithGoogleMaps(shelter: Shelter) {
    let urlString = "comgooglemaps://?daddr=\(shelter.location.coordinate.latitude),\(shelter.location.coordinate.longitude)&directionsmode=driving"
    
    if let url = URL(string: urlString) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

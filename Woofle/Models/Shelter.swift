//
//  Shelter.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation
import CoreLocation

struct Shelter: Identifiable, Codable {
    let id: UUID
    let name: String
    let location: GeoLocation
    let phoneNumber: String
}

struct GeoLocation: Codable {
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

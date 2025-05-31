//
//  MapPickerView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 31/05/25.
//
import SwiftUI
import MapKit
import CoreLocation

struct MapPickerView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var selectedLocation: String?

    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.52, longitude: 13.405),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State private var searchQuery = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var isSearching = false

    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
            HStack {
                TextField("Search for a place", text: $searchQuery, onCommit: performSearch)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)

                if isSearching {
                    ProgressView()
                        .padding(.trailing)
                }
            }
            .padding(.top)

            // Search results
            if !searchResults.isEmpty {
                List(searchResults, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text(item.name ?? "Unknown")
                            .font(.headline)
                        Text(item.placemark.title ?? "")
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        selectLocation(item)
                    }
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: 200)
            }

            // Map View
            ZStack {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)

                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .shadow(radius: 3)
                    .offset(y: -20)
            }

            // Choose button
            Button("Choose this location") {
                selectedCoordinate = region.center
                reverseGeocode(coordinate: region.center) { address in
                    selectedLocation = address ?? "Selected location"
                    dismiss()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(hex: "A3B18A"))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
    }

    func performSearch() {
        guard !searchQuery.isEmpty else { return }
        isSearching = true

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            isSearching = false
            searchResults = response?.mapItems ?? []
        }
    }

    func selectLocation(_ item: MKMapItem) {
        region.center = item.placemark.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        searchQuery = item.name ?? ""
        searchResults = []
    }

    private func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let place = placemarks?.first {
                let address = [place.locality, place.country].compactMap { $0 }.joined(separator: ", ")
                completion(address)
            } else {
                completion(nil)
            }
        }
    }
}

//
//  MapPickerView.swift
//  Woofle
//
//  Created by Jesse Brown on 2/6/2025.
//

import SwiftUI
import MapKit

struct MapPickerView2: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var selectedLocation: String?

    @State private var locationQuery = ""
    @StateObject private var completer = LocationSearchCompleter()
    @StateObject private var locationManager = LocationManager()

    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Full-screen Map
                Map(coordinateRegion: $mapRegion, annotationItems: selectedCoordinate.map { [MapPin(coordinate: $0)] } ?? []) { pin in
                    MapMarker(coordinate: pin.coordinate, tint: .blue)
                }
                .ignoresSafeArea()

                // Overlay: Search Field + Suggestions
                VStack(spacing: 0) {
                    // Search Field
                    TextField("Search for a place", text: $locationQuery)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 16)
                        .onChange(of: locationQuery) { newValue in
                            completer.updateQuery(newValue)
                        }

                    // Suggestions
                    if !completer.suggestions.isEmpty {
                        let maxSuggestions = 5
                        let visibleSuggestions = Array(completer.suggestions.prefix(maxSuggestions))

                        VStack(spacing: 0) {
                            ForEach(visibleSuggestions, id: \.self) { suggestion in
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(suggestion.title)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    if !suggestion.subtitle.isEmpty {
                                        Text(suggestion.subtitle)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    let request = MKLocalSearch.Request(completion: suggestion)
                                    let search = MKLocalSearch(request: request)
                                    search.start { response, error in
                                        guard let item = response?.mapItems.first else { return }
                                        let coordinate = item.placemark.coordinate
                                        selectedCoordinate = coordinate
                                        selectedLocation = item.name
                                        mapRegion.center = coordinate
                                        dismiss()
                                    }
                                }

                                if suggestion != visibleSuggestions.last {
                                    Divider()
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.top, 4)
                        .animation(.easeInOut(duration: 0.2), value: completer.suggestions.count)
                    }

                    Spacer()
                }
            }
            .navigationTitle("Pick Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onReceive(locationManager.$lastKnownCoordinate) { location in
                if let location = location {
                    mapRegion.center = location
                } else {
                    // fallback if location can't be determined
                    mapRegion.center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // SF
                }
            }
        }
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}





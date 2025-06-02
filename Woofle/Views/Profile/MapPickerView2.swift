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

    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var locationQuery = ""
    @StateObject private var completer = LocationSearchCompleter()

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

                    // Suggestions List
                    if !completer.suggestions.isEmpty {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(completer.suggestions, id: \.self) { suggestion in
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(suggestion.title)
                                            .fontWeight(.medium)
                                        if !suggestion.subtitle.isEmpty {
                                            Text(suggestion.subtitle)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
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

                                    Divider()
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding(.horizontal)
                        }
                        .frame(maxHeight: 200) // Limit height
                        .padding(.top, 4)
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
        }
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}



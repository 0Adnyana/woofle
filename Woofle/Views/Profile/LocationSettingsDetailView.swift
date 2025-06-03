//
//  LocationSettingsDetailView.swift
//  Woofle
//
//  Created by Rahel on 31/05/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationSettingsDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var selectedLocation: String? = nil
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    @State private var selectedRadius: Int = 30
    @State private var showRadiusPicker = false
    @State private var showMapPicker = false
    @State private var radiusSelected = false
    

    var body: some View {
        VStack(spacing: 20) {
            // Header
            ZStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 20, weight: .medium))
                    }
                    Spacer()
                }
                Text("Location Settings")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)

            Spacer().frame(height: 10)

            // Location Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Where do you live?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)

                Button(action: {
                    showMapPicker = true
                }) {
                    Text(selectedLocation ?? "Location")
                        .foregroundColor(selectedLocation == nil ? .secondary : .primary)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showMapPicker) {
                MapPickerView2(selectedCoordinate: $selectedCoordinate, selectedLocation: $selectedLocation)
            }


            // Distance Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Distance between you and the dog shelter:")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.top, 40)

                Button(action: {
                    showRadiusPicker.toggle()
                }) {
                    Text("\(selectedRadius) km")
                        .foregroundColor(radiusSelected ? .primary : .secondary)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }

                if showRadiusPicker {
                    Picker("Radius", selection: Binding(
                        get: { selectedRadius },
                        set: { newValue in
                            selectedRadius = newValue
                            radiusSelected = true
                        }
                    )) {
                        ForEach(1...300, id: \.self) { value in
                            Text("\(value) km").tag(value)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Disclaimer
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "questionmark.circle.fill")
                    .foregroundColor(Color.gray.opacity(0.5))
                    .font(.system(size: 18))

                Text("We use your area to show dogs near you.")
                    .foregroundColor(Color.gray.opacity(0.5))
                    .font(.system(size: 15))
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            // Save Button
            Button(action: {
                saveChanges()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((selectedCoordinate != nil && selectedLocation != nil) ? Color(hex: "A3B18A") : Color.gray.opacity(0.3))
                    .foregroundColor((selectedCoordinate != nil && selectedLocation != nil) ? .white : .gray)
                    .cornerRadius(12)
            }
            .disabled(selectedCoordinate == nil || selectedLocation == nil)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .onAppear {
            let user = userViewModel.user
            selectedCoordinate = CLLocationCoordinate2D(latitude: user.location.latitude, longitude: user.location.longitude)
            selectedRadius = Int(user.preferences.preferredRadius)
            radiusSelected = true
            reverseGeocode(coordinate: selectedCoordinate!) { address in
                selectedLocation = address ?? "Your location"
            }
        }
        //.background(Color.white)
        .padding(.top, 30)
        .navigationBarBackButtonHidden()
    }

    private func saveChanges() {
        guard let coordinate = selectedCoordinate else { return }

        let existingUser = userViewModel.user
        let locationCoordinates = GeoLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

//        let updatedUser = UserProfile(
//            id: existingUser.id,
//            name: existingUser.name,
//            gender: existingUser.gender,
//            age: existingUser.age,
//            location: GeoLocation(latitude: coordinate.latitude, longitude: coordinate.longitude),
//            preferences: UserPreferences(
//                preferredBreeds: existingUser.preferences.preferredBreeds,
//                sizePreferences: existingUser.preferences.sizePreferences,
//                activityLevels: existingUser.preferences.activityLevels,
//                goodWithKids: existingUser.preferences.goodWithKids,
//                goodWithOtherDogs: existingUser.preferences.goodWithOtherDogs,
//                personalityPreferences: existingUser.preferences.personalityPreferences,
//                preferredRadius: Double(selectedRadius)
//            )
//        )

        userViewModel.updateLocation(locationCoordinates)
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


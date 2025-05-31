//
//  LocationView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

//
//  LocationView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

import SwiftUI
import MapKit
import CoreLocation

// MARK: - LocationView

struct LocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var selectedLocation: String? = nil
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    @State private var selectedRadius: Int = 30
    @State private var showRadiusPicker = false
    @State private var showMapPicker = false
    @State private var radiusSelected = false
    
    @State private var navigateNext = false 

    var isFormComplete: Bool {
        selectedLocation != nil && selectedRadius > 0
    }

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

                Text("About you")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)

            // Progress bar
            HStack(spacing: 8) {
                ForEach(0..<3) { _ in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)
                        Capsule()
                            .fill(Color(hex: "F8CE9B"))
                            .frame(height: 10)
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)

            // Location Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Where do you live?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)

                Button(action: {
                    showMapPicker = true
                }) {
                    Text(selectedLocation ?? "Location")
                        .foregroundColor(selectedLocation == nil ? .gray : .black)
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
                MapPickerView(selectedCoordinate: $selectedCoordinate, selectedLocation: $selectedLocation)
            }

            // Distance Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Max distance to shelter")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.top, 57)
                    .multilineTextAlignment(.leading)

                Button(action: {
                    showRadiusPicker.toggle()
                }) {
                    Text("\(selectedRadius) km")
                        .foregroundColor(radiusSelected ? .black : .gray)
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
                    .foregroundColor(Color(hex: "B8B8B8"))
                    .font(.system(size: 18))

                Text("We use your area to show dogs near you")
                    .foregroundColor(Color(hex: "B8B8B8"))
                    .font(.system(size: 15))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            // Next Button
            Button(action: {
                guard let coordinate = selectedCoordinate else { return }

                let existingUser = userViewModel.user

                let updatedUser = UserProfile(
                    id: existingUser.id,
                    name: existingUser.name,
                    gender: existingUser.gender,
                    age: existingUser.age,
                    location: GeoLocation(latitude: coordinate.latitude, longitude: coordinate.longitude),
                    preferences: UserPreferences(
                        preferredBreeds: existingUser.preferences.preferredBreeds,
                        sizePreferences: existingUser.preferences.sizePreferences,
                        activityLevels: existingUser.preferences.activityLevels,
                        goodWithKids: existingUser.preferences.goodWithKids,
                        goodWithOtherDogs: existingUser.preferences.goodWithOtherDogs,
                        personalityPreferences: existingUser.preferences.personalityPreferences,
                        preferredRadius: Double(selectedRadius)
                    )
                )

                userViewModel.update(updatedUser)
                navigateNext = true  // <-- trigger navigation instead of dismissing

            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormComplete ? Color(hex: "A3B18A") : Color.gray.opacity(0.3))
                    .foregroundColor(isFormComplete ? .white : .gray)
                    .cornerRadius(12)
            }
            .disabled(!isFormComplete)
            .padding(.horizontal)
            .padding(.bottom, 40)
            
            // Hidden NavigationLink to DogGenderSizeView
            NavigationLink(
                destination: DogGenderSizeView().environmentObject(userViewModel),
                isActive: $navigateNext,
                label: { EmptyView() }
            )
            .hidden()
            .navigationBarBackButtonHidden()

        }
        .padding(.top, 30)
        .background(Color.white)
    }
}

//PREVIEW
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationView()
                .environmentObject(UserViewModel())
        }
    }
}



//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct LocationView: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    @State private var selectedLocation: String? = nil
//    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
//    @State private var selectedRadius: Int = 30
//    @State private var showRadiusPicker = false
//    @State private var showMapPicker = false
//    
//    @State private var radiusSelected = false
//
//
//    var isFormComplete: Bool {
//        selectedLocation != nil && selectedRadius > 0
//    }
//
//    var body: some View {
//        VStack(spacing: 20) {
//            // Header
//            ZStack {
//                HStack {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(Color(hex: "B67A4B"))
//                            .font(.system(size: 20, weight: .medium))
//                    }
//                    Spacer()
//                }
//
//                Text("About you")
//                    .font(.headline)
//                    .foregroundColor(.black)
//            }
//            .padding(.horizontal)
//
//            // Progress bar
//            HStack(spacing: 8) {
//                ForEach(0..<3) { index in
//                    ZStack {
//                        Capsule()
//                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)  // stroke with custom hex color
//                            .frame(height: 10)
//
//                        if index < 3 {
//                            Capsule()
//                                .fill(Color(hex: "F8CE9B"))             // fill with your lighter custom color
//                                .frame(height: 10)
//                        }
//                    }
//                }
//            }
//
//            .padding(.horizontal)
//
//            Spacer().frame(height: 5)
//
//            // Location picker
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Where do you live?")
//                    .font(.system(size: 24, weight: .semibold))
//                    .foregroundColor(.black)
//
//                Button(action: {
//                    showMapPicker = true
//                }) {
//                    Text(selectedLocation ?? "Location")
//                        .foregroundColor(selectedLocation == nil ? .gray : .black)
//                        .frame(height: 50)
//                        .frame(maxWidth: .infinity)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
//                }
//            }
//            .padding(.horizontal)
//            .sheet(isPresented: $showMapPicker) {
//                MapPickerView(selectedCoordinate: $selectedCoordinate, selectedLocation: $selectedLocation)
//            }
//
//            // Distance picker
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Distance between you and the dog shelter:")
//                    .font(.system(size: 24, weight: .semibold))
//                    .foregroundColor(.black)
//                    .padding(.top, 57)
//
//                Button(action: {
//                    showRadiusPicker.toggle()
//                }) {
//                    Text("\(selectedRadius) km")
//                        .foregroundColor(radiusSelected ? .black : .gray)
//                        .frame(height: 50)
//                        .frame(maxWidth: .infinity)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
//                }
//
//                if showRadiusPicker {
//                    Picker("Radius", selection: Binding(
//                        get: { selectedRadius },
//                        set: { newValue in
//                            selectedRadius = newValue
//                            radiusSelected = true
//                        }
//                    )) {
//                        ForEach(1...300, id: \.self) { value in
//                            Text("\(value) km").tag(value)
//                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    .frame(height: 120)
//                }
//            }
//            .padding(.horizontal)
//
//            Spacer()
//
//            // Disclaimer
//            HStack(alignment: .top, spacing: 6) {
//                Image(systemName: "questionmark.circle.fill")
//                    .foregroundColor(Color.gray.opacity(0.5))
//                    .font(.system(size: 18))
//
//                Text("We use your area to show dogs near you.")
//                    .foregroundColor(Color.gray.opacity(0.5))
//                    .font(.system(size: 15))
//                    .fixedSize(horizontal: false, vertical: true)
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 8)
//
//            // Next button
//            Button(action: {
//                print("Location: \(selectedLocation ?? "")")
//                print("Radius: \(selectedRadius) km")
//            }) {
//                Text("Next")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(isFormComplete ? Color(hex: "A3B18A") : Color.gray.opacity(0.3))
//                    .foregroundColor(isFormComplete ? .white : .gray)
//                    .cornerRadius(12)
//            }
//            .disabled(!isFormComplete)
//            .padding(.horizontal)
//            .padding(.bottom, 40)
//        }
//        .padding(.top, 30)
//        .background(Color.white)
//    }
//}
//
//// Right after LocationView ends
//
//import SwiftUI
//import MapKit
//
//struct MapPickerView: View {
//    @Environment(\.dismiss) var dismiss
//
//    @Binding var selectedCoordinate: CLLocationCoordinate2D?
//    @Binding var selectedLocation: String?
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 52.52, longitude: 13.405),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
//    
//    @State private var searchQuery = ""
//    @State private var searchResults: [MKMapItem] = []
//    @State private var isSearching = false
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // Search Bar
//            HStack {
//                TextField("Search for a place", text: $searchQuery, onCommit: {
//                    performSearch()
//                })
//                .padding(.horizontal)
//                .frame(height: 50)
//                .frame(maxWidth: .infinity)
//                .background(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color.gray, lineWidth: 1)
//                )
//                .padding(.horizontal)
//
//                if isSearching {
//                    ProgressView()
//                        .padding(.trailing)
//                }
//            }
//            .padding(.top)
//
//
//            // Search results list
//            if !searchResults.isEmpty {
//                List(searchResults, id: \.self) { item in
//                    VStack(alignment: .leading) {
//                        Text(item.name ?? "Unknown")
//                            .font(.headline)
//                        Text(item.placemark.title ?? "")
//                            .font(.subheadline)
//                    }
//                    .onTapGesture {
//                        selectLocation(item)
//                    }
//                }
//                .listStyle(PlainListStyle())
//                .frame(maxHeight: 200)
//            }
//
//            // Map
//            ZStack {
//                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
//                    .edgesIgnoringSafeArea(.all)
//
//                // Pin Image fixed at center
//                Image(systemName: "mappin.circle.fill")
//                    .font(.system(size: 40))
//                    .foregroundColor(.red)
//                    .shadow(radius: 3)
//                    .offset(y: -20) // lifts the pin a bit so the tip points exactly
//            }
//
//
//            Button("Choose this location") {
//                selectedCoordinate = region.center
//                reverseGeocode(coordinate: region.center) { address in
//                    selectedLocation = address ?? "Selected location"
//                    dismiss()
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color(hex: "A3B18A"))
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .padding()
//        }
//    }
//
//    func performSearch() {
//        guard !searchQuery.isEmpty else { return }
//        isSearching = true
//        
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchQuery
//        
//        let search = MKLocalSearch(request: request)
//        search.start { response, error in
//            isSearching = false
//            if let response = response {
//                searchResults = response.mapItems
//            } else {
//                searchResults = []
//            }
//        }
//    }
//
//    func selectLocation(_ item: MKMapItem) {
//        // Update the region to center on selected place
//        region.center = item.placemark.coordinate
//        region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        searchResults = []
//        searchQuery = item.name ?? ""
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                let address = [place.locality, place.country].compactMap { $0 }.joined(separator: ", ")
//                completion(address)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//}
//
//struct LocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationView()
//    }
//}
//
//
//

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
    
    @StateObject private var locationManager = LocationManager()
    
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
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)
            
            // Progress bar (3 of 4 steps → 3 filled bars)
            HStack(spacing: 8) {
                ForEach(0..<4) { index in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)
                        
                        if index < 3 { // Only fill first 3 bars
                            Capsule()
                                .fill(Color(hex: "F8CE9B"))
                                .frame(height: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)
            
            // Location Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Where do you live?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)
                
                Button(action: {
                    showMapPicker = true
                }) {
                    Text(selectedLocation ?? "Location")
                        .foregroundColor(selectedLocation == nil ? .gray : .primary)
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
                Text("Max distance to shelter")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.top, 57)
                    .multilineTextAlignment(.leading)
                
                Button(action: {
                    showRadiusPicker.toggle()
                }) {
                    Text("\(selectedRadius) km")
                        .foregroundColor(radiusSelected ? .primary : .gray)
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
                    
                    userViewModel.updateLocation(GeoLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
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
                .navigationDestination(isPresented: $navigateNext) {
                    DogGoodWithKidsDogs()
                }
                .navigationBarBackButtonHidden()
                
                //
                
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


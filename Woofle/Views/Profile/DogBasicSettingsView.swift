//
//  DogBasicSettingsView.swift
//  Woofle
//
//  Created by Rahel on 01/06/25.
//

import SwiftUI

struct DogBasicsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - State Variables
    @State private var selectedGenders: Set<String> = []
    @State private var selectedSizes: Set<String> = []
    @State private var selectedEnergyLevels: Set<String> = []
    @State private var selectedBreeds: Set<String> = []
    
    // MARK: - Data Arrays
    let dogGenders: [String]
    let sizes: [String]
    let energyLevels: [String]
    let breeds: [String]
    
    init() {
        self.breeds = BreedLoader.loadBreeds()
        self.dogGenders = DogGender.allCases.map { $0.rawValue }
        self.sizes = Size.allCases.map { $0.rawValue }
        self.energyLevels = EnergyLevel.allCases.map { $0.rawValue }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
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
                    Text("Dog Basics")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Gender Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Preferred gender?")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    ForEach(dogGenders, id: \.self) { gender in
                        genderToggleButton(title: gender)
                    }
                    .padding(.horizontal)
                }
                
                // Size Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose preferred sizes:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    ForEach(sizes, id: \.self) { size in
                        sizeSelectableRow(title: size)
                    }
                    .padding(.horizontal)
                }
                
                // Energy Level Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose matching energy levels:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    ForEach(energyLevels, id: \.self) { level in
                        energySelectableRow(title: level)
                    }
                    .padding(.horizontal)
                }
                
                // Breeds Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose breeds you like:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    ForEach(breeds, id: \.self) { breed in
                        breedSelectableRow(title: breed)
                    }
                    .padding(.horizontal)
                }
                
                Spacer().frame(height: 20)
                
                // Save Button
                Button(action: {
                    saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "A3B18A"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear(perform: loadCurrentPreferences)
    }
    
    // MARK: - UI Components
    
    func genderToggleButton(title: String) -> some View {
        Button {
            if selectedGenders.contains(title) {
                selectedGenders.remove(title)
            } else {
                selectedGenders.insert(title)
            }
        } label: {
            HStack {
                Text(title.capitalized)
                    .foregroundColor(selectedGenders.contains(title) ? .black : .gray)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(selectedGenders.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    if selectedGenders.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedGenders.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedGenders.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    func sizeSelectableRow(title: String) -> some View {
        Button {
            if selectedSizes.contains(title) {
                selectedSizes.remove(title)
            } else {
                selectedSizes.insert(title)
            }
        } label: {
            HStack {
                Text(title.capitalized)
                    .foregroundColor(selectedSizes.contains(title) ? .black : .gray)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(selectedSizes.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    if selectedSizes.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedSizes.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedSizes.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    func energySelectableRow(title: String) -> some View {
        Button(action: {
            if selectedEnergyLevels.contains(title) {
                selectedEnergyLevels.remove(title)
            } else {
                selectedEnergyLevels.insert(title)
            }
        }) {
            HStack {
                Text(title.capitalized)
                    .foregroundColor(selectedEnergyLevels.contains(title) ? .black : .gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(selectedEnergyLevels.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if selectedEnergyLevels.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedEnergyLevels.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedEnergyLevels.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    func breedSelectableRow(title: String) -> some View {
        Button(action: {
            if selectedBreeds.contains(title) {
                selectedBreeds.remove(title)
            } else {
                selectedBreeds.insert(title)
            }
        }) {
            HStack {
                Text(title)
                    .foregroundColor(selectedBreeds.contains(title) ? .black : .gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(selectedBreeds.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if selectedBreeds.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedBreeds.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedBreeds.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    // MARK: - Data Management
    private func loadCurrentPreferences() {
        let preferences = userViewModel.user.preferences
        
        // Load existing gender preference if you have it stored
        // Note: I don't see gender preference in your UserPreferences struct
        // You might need to add this field to your data model
        
        // Load size preferences
        selectedSizes = Set(preferences.sizePreferences.compactMap() {
            switch $0 {
            case .small: return "small"
            case .medium: return "medium"
            case .large: return "large"
            default: return nil
            }
        })
        
        selectedGenders = Set(preferences.genderPreferences.map { $0.rawValue })
        
        // Load energy levels
        selectedEnergyLevels = Set(
            preferences.activityLevels.compactMap {
                switch $0 {
                case .low: return "Low"
                case .moderate: return "Middle"
                case .high: return "High"
                default: return nil
                }
            }
        )
        
        // Load preferred breeds
        selectedBreeds = Set(preferences.preferredBreeds ?? [])

    }
    
    private func saveChanges() {
        
        // Convert selectedSizes to Size enum array
        let sizesEnum: [Size] = selectedSizes.compactMap { sizeString in
            switch sizeString.lowercased() {
            case "small": return .small
            case "medium": return .medium
            case "large": return .large
            default: return nil
            }
        }
        
        let genderEnum = selectedGenders.compactMap {
            DogGender(rawValue: $0.lowercased())
        }
        
        // Convert selectedEnergyLevels to EnergyLevel enum array
        let energyLevelsEnum: [EnergyLevel] = selectedEnergyLevels.compactMap { levelString in
            switch levelString {
            case "Low": return .low
            case "Middle": return .moderate
            case "High": return .high
            default: return nil
            }
        }
        
        // Update Preferences
        var updatedPreferences = userViewModel.user.preferences
        updatedPreferences.sizePreferences = sizesEnum
        updatedPreferences.genderPreferences = genderEnum
        updatedPreferences.activityLevels = energyLevelsEnum
        updatedPreferences.preferredBreeds = Array(selectedBreeds)
        
        userViewModel.updateUserPreferences(updatedPreferences)
    }
}

#Preview {
    NavigationView {
        DogBasicsView()
            .environmentObject(UserViewModel())
    }
}

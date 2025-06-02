//
//  DogBehaviourView.swift
//  Woofle
//
//  Created by Rahel on 02/06/25.
//


import SwiftUI

struct DogBehaviourView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - State Variables
    @State private var selectedPersonalities: Set<String> = []
    @State private var isGoodWithKids: Bool = false
    @State private var isGoodWithOtherDogs: Bool = false
    
    // MARK: - Data Arrays
    let personalities = ["Playful", "Calm", "Curious", "Affectionate", "Protective", "Independent"]
    
    var body: some View {

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
                    Text("Dog Behaviour")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Personality Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose preferred personalities:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    ForEach(personalities, id: \.self) { personality in
                        personalitySelectableRow(title: personality)
                    }
                    .padding(.horizontal)
                }
                
                // Good With Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("The dog should be:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    goodWithKidsRow()
                        .padding(.horizontal)
                    
                    goodWithOtherDogsRow()
                        .padding(.horizontal)
                }
                
                Spacer().frame(height: 10)
                
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
            }
        .onAppear(perform: loadCurrentPreferences)
    }
    
    // MARK: - UI Components
    func personalitySelectableRow(title: String) -> some View {
        Button(action: {
            if selectedPersonalities.contains(title) {
                selectedPersonalities.remove(title)
            } else {
                selectedPersonalities.insert(title)
            }
        }) {
            HStack {
                Text(title)
                    .foregroundColor(selectedPersonalities.contains(title) ? .black : .gray)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(selectedPersonalities.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if selectedPersonalities.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedPersonalities.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedPersonalities.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    func goodWithKidsRow() -> some View {
        Button(action: {
            isGoodWithKids.toggle()
        }) {
            HStack {
                Text("Good with kids")
                    .foregroundColor(isGoodWithKids ? .black : .gray)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(isGoodWithKids ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isGoodWithKids {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(isGoodWithKids ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isGoodWithKids ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    func goodWithOtherDogsRow() -> some View {
        Button(action: {
            isGoodWithOtherDogs.toggle()
        }) {
            HStack {
                Text("Good with other dogs")
                    .foregroundColor(isGoodWithOtherDogs ? .black : .gray)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    Circle()
                        .stroke(isGoodWithOtherDogs ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isGoodWithOtherDogs {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(isGoodWithOtherDogs ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isGoodWithOtherDogs ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
    
    // MARK: - Data Management
    private func loadCurrentPreferences() {
        let preferences = userViewModel.user.preferences
        
        // Load personality preferences - convert PersonalityTrait enum to strings
        selectedPersonalities = Set(preferences.personalityPreferences.compactMap { trait in
            trait.rawValue.capitalized
        } ?? [])
        
        // Load good with kids/dogs preferences
        isGoodWithKids = preferences.goodWithKids ?? false
        isGoodWithOtherDogs = preferences.goodWithOtherDogs ?? false
    }
    
    private func saveChanges() {
        let current = userViewModel.user
        
        // Convert selected personalities from strings to PersonalityTrait enum
        let personalityTraits = selectedPersonalities.compactMap { trait in
            PersonalityTrait(rawValue: trait.lowercased())
        }
        
        // Create updated preferences
        let updatedPreferences = UserPreferences(
            preferredBreeds: current.preferences.preferredBreeds,
            sizePreferences: current.preferences.sizePreferences,
            activityLevels: current.preferences.activityLevels,
            goodWithKids: isGoodWithKids,
            goodWithOtherDogs: isGoodWithOtherDogs,
            personalityPreferences: personalityTraits,
            preferredRadius: current.preferences.preferredRadius
        )
        
        // Create updated user profile
        let updatedUser = UserProfile(
            id: current.id,
            name: current.name,
            gender: current.gender,
            age: current.age,
            location: current.location,
            preferences: updatedPreferences
        )
        
        userViewModel.update(updatedUser)
    }
}

#Preview {
    NavigationView {
        DogBehaviourView()
            .environmentObject(UserViewModel())
    }
}

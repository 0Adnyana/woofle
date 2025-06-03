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
    
    // MARK: - Data Arrays
    let personalities: [String]
    
    init() {
        self.personalities = PersonalityTrait.allCases.map { $0.rawValue }
    }
    
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
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView {
                // Personality Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose preferred personalities:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    ForEach(personalities, id: \.self) { personality in
                        personalitySelectableRow(title: personality)
                    }
                    .padding(.horizontal)
                }
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
            .padding(.bottom, 40)
        }
        .onAppear(perform: loadCurrentPreferences)
        .navigationBarBackButtonHidden()
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
                Text(title.capitalized)
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
    
    // MARK: - Data Management
    private func loadCurrentPreferences() {
        let preferences = userViewModel.user.preferences
        
        //        selectedPersonalities = Set(preferences.personalityPreferences.compactMap { trait in
        //            trait.rawValue.capitalized
        //        } ?? [])
        
        selectedPersonalities = Set(preferences.personalityPreferences.map { $0.rawValue })
        
        
        // Load good with kids/dogs preferences
    }
    
    private func saveChanges() {
        // Convert selected personalities from strings to PersonalityTrait enum
        let personalityTraits = selectedPersonalities.compactMap { trait in
            PersonalityTrait(rawValue: trait.lowercased())
        }
        
        userViewModel.updatePersonalityPreferences(personalityTraits)
    }
}

#Preview {
    NavigationView {
        DogBehaviourView()
            .environmentObject(UserViewModel())
    }
}


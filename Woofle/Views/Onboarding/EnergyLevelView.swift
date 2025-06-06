//
//  EnergyLevelView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//
import SwiftUI

struct EnergyLevelView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var selectedLevels: Set<String> = []

    let energyLevels: [String]

    @State private var navigateToNext = false

    init() {
        self.energyLevels = EnergyLevel.allCases.map { $0.rawValue }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Top Navigation
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "B67A4B"))
                        .font(.system(size: 20, weight: .medium))
                }
                
                Spacer()
                
                Text("About your future dog")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                NavigationLink(destination: TabBarView()) {
                    Text("Skip")
                        .foregroundColor(Color(hex: "B67A4B"))
                        .fontWeight(.medium)
                }.simultaneousGesture(TapGesture().onEnded {
                    userViewModel.completeOnboarding()
                })
            }
            .padding(.horizontal)
                    
            // Progress bar (2 of 5 filled)
            HStack(spacing: 8) {
                ForEach(0..<4) { index in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)
                        
                        if index < 2 {
                            Capsule()
                                .fill(Color(hex: "F8CE9B"))
                                .frame(height: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer().frame(height: 5)
            
            // Question
            VStack(alignment: .leading, spacing: 12) {
                Text("How much energy should your dog have?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)
                
                ForEach(energyLevels, id: \.self) { level in
                    energySelectableRow(title: level)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Next button - disabled if none selected
            Button(action: {
                saveSelection()
                navigateToNext = true
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "A0B58E")) // always green
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .padding(.top, 30)
//        .onAppear(perform: loadCurrentPreferences)
        .navigationDestination(isPresented: $navigateToNext) {
                        PersonalityPreferenceView()
                    }
                    .navigationBarBackButtonHidden()
    }
    

    // MARK: - Energy Selectable Row
    func energySelectableRow(title: String) -> some View {
        Button(action: {
            if selectedLevels.contains(title) {
                selectedLevels.remove(title)
            } else {
                selectedLevels.insert(title)
            }
        }) {
            HStack {
                Text(title.capitalized)
                    .foregroundColor(selectedLevels.contains(title) ? .black : .gray)
                    .frame(maxWidth: .infinity, alignment: .center)

                ZStack {
                    Circle()
                        .stroke(selectedLevels.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if selectedLevels.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedLevels.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedLevels.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }

    // Load current user preferences and map to selectedLevels strings
//    private func loadCurrentPreferences() {
//        // Your UserPreferences.activityLevels is [EnergyLevel]
//        // Map EnergyLevel enum cases to string matching "Low", "Middle", "High"
//        selectedLevels = Set(
//            userViewModel.user.preferences.activityLevels.compactMap {
//                switch $0 {
//                case .low: return "Low"
//                case .moderate: return "Middle"
//                case .high: return "High"
//                default: return nil
//                }
//            }
//        )
//    }

    // Save current selection back to userViewModel
    private func saveSelection() {

        // Map strings back to EnergyLevel enum
        let mappedLevels: [EnergyLevel] = selectedLevels.compactMap { levelString in
            switch levelString {
            case "low": return .low
            case "moderate": return .moderate
            case "high": return .high
            default: return nil
            }
        }


        userViewModel.updateActivityLevels(mappedLevels)
    }
}







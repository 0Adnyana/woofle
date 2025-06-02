
//
//  DogGenderSizeView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

import SwiftUI

struct DogGenderSizeView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var selectedGender: String? = nil
    @State private var selectedSizes: Set<String> = []
    @State private var navigateToNext = false

    let sizes = ["small", "middle", "high"]

    var body: some View {
        VStack(spacing: 20) {
            // Top Nav
            HStack {
                Spacer()
                Text("About your dog")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button("Skip") {
                    navigateToNext = true
                }
                .foregroundColor(Color(hex: "B67A4B"))
                .fontWeight(.medium)
            }
            .padding(.horizontal)

            // Progress Bar (Step 1 of 5)
            HStack(spacing: 8) {
                ForEach(0..<5) { index in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)
                        if index == 0 {
                            Capsule()
                                .fill(Color(hex: "F8CE9B"))
                                .frame(height: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)

            // Preferred Gender
            VStack(alignment: .leading, spacing: 12) {
                Text("Preferred gender?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                HStack {
                    genderButton(title: "female")
                    genderButton(title: "male")
                }
            }
            .padding(.horizontal)

            // Preferred Sizes
            VStack(alignment: .leading, spacing: 12) {
                Text("Choose preferred sizes:")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)

                ForEach(sizes, id: \.self) { size in
                    sizeSelectableRow(title: size)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Next Button
            Button(action: {
                savePreferences()
                navigateToNext = true
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "A3B18A"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)

            // Navigation
            NavigationLink(destination: EnergyLevelView(), isActive: $navigateToNext) {
                EmptyView()
            }
            .hidden()
        }
        .padding(.top, 30)
        .background(Color.white)
        .navigationBarBackButtonHidden()
    }

    // MARK: - Save to Environment
    func savePreferences() {
        let existing = userViewModel.user

        // Convert selectedSizes (Set<String>) to [Size]
        let sizesEnum = selectedSizes.compactMap { Size(rawValue: $0.lowercased()) }

        // Keep other preferences the same but update sizes
        let updatedPreferences = UserPreferences(
            preferredBreeds: existing.preferences.preferredBreeds,
            sizePreferences: sizesEnum,
            activityLevels: existing.preferences.activityLevels,
            goodWithKids: existing.preferences.goodWithKids,
            goodWithOtherDogs: existing.preferences.goodWithOtherDogs,
            personalityPreferences: existing.preferences.personalityPreferences,
            preferredRadius: existing.preferences.preferredRadius
        )

        // Gender is not saved here; if you want to save gender similarly, convert and assign it

        let updatedUser = UserProfile(
            id: existing.id,
            name: existing.name,
            gender: existing.gender,   // unchanged
            age: existing.age,
            location: existing.location,
            preferences: updatedPreferences
        )

        userViewModel.update(updatedUser)
    }


    // MARK: - UI Components
    func genderButton(title: String) -> some View {
        Button {
            selectedGender = selectedGender == title ? nil : title
        } label: {
            Text(title.capitalized)
                .foregroundColor(selectedGender == title ? .black : .gray)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(selectedGender == title ? Color(hex: "F8EEDF") : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(selectedGender == title ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
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
                Spacer()
                Text(title.capitalized)
                    .foregroundColor(selectedSizes.contains(title) ? .black : .gray)
                    .font(.system(size: 16))
                Spacer()
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
}



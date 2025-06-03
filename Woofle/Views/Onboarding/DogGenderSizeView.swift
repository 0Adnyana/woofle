
//
//  DogGenderSizeView.swift
//  Woofle
//
//  Created by Rahel on 30/05/25.
//

import SwiftUI

struct DogGenderSizeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var selectedGenders: Set<String> = []
    @State private var selectedSizes: Set<String> = []
    @State private var navigateToNext = false

    let sizes = ["small", "medium", "large"]
    let dogGenders = ["female", "male"]

    var body: some View {
        
        VStack(spacing: 20) {
            // Header
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

            // Progress Bar
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
            
            // Gender Preferences
            VStack(alignment: .leading, spacing: 12) {
                Text("Preferred gender(s)?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)
                ForEach(dogGenders, id: \.self) { gender in
                    genderToggleButton(title: gender)
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)
            
            // Size Preferences
            VStack(alignment: .leading, spacing: 12) {
                Text("Choose preferred sizes:")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)

                ForEach(sizes, id: \.self) { size in
                    sizeToggleRow(title: size)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Next Button
            Button(action: {
                let finalDogGenders: [DogGender] = selectedGenders.isEmpty
                    ? dogGenders.compactMap { DogGender(rawValue: $0.lowercased()) }
                    : selectedGenders.compactMap { DogGender(rawValue: $0.lowercased()) }

                let finalSizes: [Size] = selectedSizes.isEmpty
                    ? sizes.compactMap { Size(rawValue: $0.lowercased()) }
                    : selectedSizes.compactMap { Size(rawValue: $0.lowercased()) }

                userViewModel.updateGenderPreferences(finalDogGenders)
                userViewModel.updateSizePreferences(finalSizes)

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
//            NavigationLink(destination: EnergyLevelView(), isActive: $navigateToNext) {
//                EmptyView()
//            }
//            .hidden()
        }
        .padding(.top, 30)
        .background(Color.white)
        .navigationBarBackButtonHidden()
        
        // Add this modifier to your outer VStack (or directly to the body)
        .navigationDestination(isPresented: $navigateToNext) {
            EnergyLevelView()
        }

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
                Spacer()
                Text(title.capitalized)
                    .foregroundColor(selectedGenders.contains(title) ? .primary : .gray)
                    .font(.system(size: 16))
                Spacer()
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
//            Text(title.capitalized)
//                .foregroundColor(selectedGenders.contains(title) ? .black : .gray)
//                .frame(height: 50)
//                .frame(maxWidth: .infinity)
//                .background(selectedGenders.contains(title) ? Color(hex: "F8EEDF") : Color.white)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(selectedGenders.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
//                )
//                .cornerRadius(12)
        }
    }

    func sizeToggleRow(title: String) -> some View {
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
                    .foregroundColor(selectedSizes.contains(title) ? .primary : .gray)
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

#Preview {
    DogGenderSizeView().environmentObject(UserViewModel())
}

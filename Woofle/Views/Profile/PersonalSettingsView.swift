////
////  PersonalSettingsView.swift
////  Woofle
////
////  Created by Rahel on 31/05/25.
////
//
import SwiftUI

struct PersonalSettingsDetailView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode

    // MARK: - User inputs
    @State private var nameInput: String = ""
    @State private var selectedGender: String? = nil

    // For birth year picker
    let years: [String] = Array(1900...Calendar.current.component(.year, from: Date()))
        .reversed()
        .map { String($0) }

    @State private var selectedYear: String = "2025" // will be set properly on appear
    @State private var showPicker = false

    var genders = ["Male", "Female", "Non Binary"]

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
                Text("Personal Settings")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Name Input
            ZStack(alignment: .trailing) {
                TextField("Your Name", text: $nameInput)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .submitLabel(.done)
                    .onAppear {
                        nameInput = userViewModel.user.name
                    }
                if !nameInput.isEmpty {
                    Button(action: {
                        saveChanges()
                    }) {
                        Image(systemName: "arrow.turn.down.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .padding(.trailing, 8)
                }
            }
            .frame(width: 350, height: 50)
            .padding(.horizontal, 40)
            .padding(.top, 10)

            // Gender buttons
            VStack(spacing: 16) {
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        selectedGender = gender
                    }) {
                        Text(gender)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                selectedGender == gender ? Color(red: 0.996, green: 0.961, blue: 0.922) : Color.white
                            )
                            .foregroundColor(selectedGender == gender ? .black : Color.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        selectedGender == gender ? Color(red: 0.631, green: 0.384, blue: 0.192) : Color.gray,
                                        lineWidth: 1
                                    )
                            )
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal, 40)
            .onAppear {
                // Set gender from userViewModel
                switch userViewModel.user.gender {
                case .male: selectedGender = "Male"
                case .female: selectedGender = "Female"
                case .other: selectedGender = "Non Binary"
                }
            }

            // Birth Year picker UI
            VStack(spacing: 8) {
                Text("What's your birth year?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)

                Button(action: {
                    showPicker.toggle()
                }) {
                    Text(selectedYear == "2025" ? "Select Year" : selectedYear)
                        .foregroundColor(selectedYear == "2025" ? Color(hex: "999999") : .black)
                        .frame(width: 350, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "999999"), lineWidth: 1)
                        )
                }

                if showPicker {
                    Picker("Birthyear", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(year).tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                }
            }
            .padding(.top, 20)
            .onAppear {
                // Calculate birth year from user age on appear
                let currentYear = Calendar.current.component(.year, from: Date())
                let birthYearFromAge = currentYear - userViewModel.user.age
                selectedYear = String(birthYearFromAge)
            }

            Spacer()

            // Save Button (always active, greenish)
            Button(action: {
                saveChanges()
            }) {
                Text("Save")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "A3B18A"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }

    // Save user changes to userViewModel
    private func saveChanges() {
        let genderEnum: HumanGender
        switch selectedGender {
        case "Male":
            genderEnum = .male
        case "Female":
            genderEnum = .female
        case "Non Binary":
            genderEnum = .other
        default:
            genderEnum = .other
        }

        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYearInt = Int(selectedYear) ?? (currentYear - userViewModel.user.age)
        let age = max(currentYear - birthYearInt, 0)

        let current = userViewModel.user
        let updatedUser = UserProfile(
            id: current.id,
            name: nameInput.isEmpty ? current.name : nameInput,
            gender: genderEnum,
            age: age,
            location: current.location,
            preferences: current.preferences
        )

        userViewModel.update(updatedUser)
    }
}


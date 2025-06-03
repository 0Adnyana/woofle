////
////  PersonalSettingsView.swift
////  Woofle
////
////  Created by Rahel on 31/05/25.
////



import SwiftUI

struct PersonalSettingsDetailView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode

    // MARK: - User inputs
    @State private var nameInput: String = ""
    @State private var selectedGender: String? = nil
    @State private var selectedYear: String = "2025"
    @State private var showPicker = false
    @State private var livesWithKids: Bool? = nil
    @State private var livesWithDogs: Bool? = nil

    let years: [String] = Array(1900...Calendar.current.component(.year, from: Date()))
        .reversed()
        .map { String($0) }

    var genders = ["Male", "Female", "Non Binary"]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) { // Reduced spacing here
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
                        .padding(.leading, 16)
                        Spacer()
                    }
                    Text("Personal Settings")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                .padding(.top, 6)  // Reduced from 10

                // Name Input
                ZStack(alignment: .trailing) {
                    TextField("Your Name", text: $nameInput)
                        .padding()
                        .background(Color.gray.opacity(0.3))
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
                                .foregroundColor(Color(hex: "D6D6D6"))
                                .padding()
                        }
                        .padding(.trailing, 8)
                    }
                }
                .frame(width: 350, height: 50)
                .padding(.horizontal, 40)

                // Gender label + buttons
                VStack(alignment: .leading, spacing: 10) { // Reduced spacing
                    Text("Gender")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)

                    VStack(spacing: 12) { // Reduced spacing
                        ForEach(genders, id: \.self) { gender in
                            Button(action: {
                                selectedGender = gender
                            }) {
                                Text(gender)
                                    .fontWeight(.semibold)
                                    .frame(width: 350, height: 50)   // consistent size
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
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)  // Reduced from 20

                // Birth Year picker
                VStack(spacing: 6) {  // Reduced spacing
                    Text("What's your birth year?")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)

                    Button(action: {
                        showPicker.toggle()
                    }) {
                        Text(selectedYear == "2025" ? "Select Year" : selectedYear)
                            .foregroundColor(selectedYear == "2025" ? Color(hex: "999999") : .primary)
                            .frame(width: 350, height: 50)  // consistent size
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
                .padding(.top, 10)  // Reduced from 20
                .padding(.horizontal, 40)

                // Kids and Dogs at home
                VStack(alignment: .leading, spacing: 16) { // Reduced spacing
                    VStack(alignment: .leading, spacing: 8) { // Reduced spacing
                        Text("Any kids at home?")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal)

                        yesNoButtons(selected: $livesWithKids)
                            .frame(width: 350)  // fixed width container
                    }

                    VStack(alignment: .leading, spacing: 8) { // Reduced spacing
                        Text("Any dogs at home?")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        
                        yesNoButtons(selected: $livesWithDogs)
                            .frame(width: 350)  // fixed width container
                    }
                }
                .padding(.horizontal, 40)

                Spacer(minLength: 40)

                // Save Button
                Button(action: {
                    saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(width:350)
                        .padding()
                        .background(isFormComplete ? Color(hex: "A3B18A") : Color.gray.opacity(0.3))
                        .foregroundColor(isFormComplete ? .white : .gray)
                        .cornerRadius(12)
                }
                .disabled(!isFormComplete)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
                        
            .navigationBarBackButtonHidden()
            .onAppear {
                // Initialize form with user data
                switch userViewModel.user.gender {
                case .male: selectedGender = "Male"
                case .female: selectedGender = "Female"
                case .other: selectedGender = "Non Binary"
                }

                let currentYear = Calendar.current.component(.year, from: Date())
                let birthYearFromAge = currentYear - userViewModel.user.age
                selectedYear = String(birthYearFromAge)

                livesWithKids = userViewModel.user.preferences.goodWithKids
                livesWithDogs = userViewModel.user.preferences.goodWithOtherDogs
            }
        }
        
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private var isFormComplete: Bool {
        !nameInput.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGender != nil &&
        selectedYear != "2025" &&
        livesWithKids != nil &&
        livesWithDogs != nil
    }

    private func saveChanges() {
        let genderEnum: HumanGender
        switch selectedGender {
        case "Male": genderEnum = .male
        case "Female": genderEnum = .female
        case "Non Binary": genderEnum = .other
        default: genderEnum = .other
        }

        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYearInt = Int(selectedYear) ?? (currentYear - userViewModel.user.age)
        let age = max(currentYear - birthYearInt, 0)

        let current = userViewModel.user

        let updatedPreferences = UserPreferences(
            preferredBreeds: current.preferences.preferredBreeds,
            sizePreferences: current.preferences.sizePreferences,
            genderPreferences: current.preferences.genderPreferences,
            activityLevels: current.preferences.activityLevels,
            goodWithKids: livesWithKids ?? false,
            goodWithOtherDogs: livesWithDogs ?? false,
            personalityPreferences: current.preferences.personalityPreferences,
            preferredRadius: current.preferences.preferredRadius
        )

        let updatedUser = UserProfile(
            id: current.id,
            name: nameInput.isEmpty ? current.name : nameInput,
            gender: genderEnum,
            age: age,
            location: current.location,
            preferences: updatedPreferences
        )

        userViewModel.updateUserProfile(updatedUser)
    }

    // MARK: - Yes/No Buttons
    func yesNoButtons(selected: Binding<Bool?>) -> some View {
        HStack(spacing: 16) {
            Button(action: { selected.wrappedValue = true }) {
                Text("Yes")
                    .fontWeight(.medium)
                    .frame(width: (350 - 16) / 2, height: 50)  // half width minus spacing
                    .background(selected.wrappedValue == true ? Color(hex: "F8EEDF") : Color.white)
                    .foregroundColor(selected.wrappedValue == true ? .black : .gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selected.wrappedValue == true ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
                    )
                    .cornerRadius(12)
            }

            Button(action: { selected.wrappedValue = false }) {
                Text("No")
                    .fontWeight(.medium)
                    .frame(width: (350 - 16) / 2, height: 50)
                    .background(selected.wrappedValue == false ? Color(hex: "F8EEDF") : Color.white)
                    .foregroundColor(selected.wrappedValue == false ? .black : .gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selected.wrappedValue == false ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
                    )
                    .cornerRadius(12)
            }
        }
    }
}



//import SwiftUI
//
//struct PersonalSettingsDetailView: View {
//    @EnvironmentObject var userViewModel: UserViewModel
//    @Environment(\.presentationMode) var presentationMode
//
//    // MARK: - User inputs
//    @State private var nameInput: String = ""
//    @State private var selectedGender: String? = nil
//    @State private var selectedYear: String = "2025"
//    @State private var showPicker = false
//    @State private var livesWithKids: Bool? = nil
//    @State private var livesWithDogs: Bool? = nil
//
//    let years: [String] = Array(1900...Calendar.current.component(.year, from: Date()))
//        .reversed()
//        .map { String($0) }
//
//    var genders = ["Male", "Female", "Non Binary"]
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
//                Text("Personal Settings")
//                    .font(.headline)
//                    .foregroundColor(.primary)
//            }
//            .padding(.horizontal)
//            .padding(.top, 10)
//
//            // Name Input
//            ZStack(alignment: .trailing) {
//                TextField("Your Name", text: $nameInput)
//                    .padding()
//                    .background(Color.gray.opacity(0.3))
//                    .cornerRadius(15)
//                    .submitLabel(.done)
//                    .onAppear {
//                        nameInput = userViewModel.user.name
//                    }
//                if !nameInput.isEmpty {
//                    Button(action: {
//                        saveChanges()
//                    }) {
//                        Image(systemName: "arrow.turn.down.left")
//                            .foregroundColor(Color(hex: "D6D6D6"))
//                            .padding()
//                    }
//                    .padding(.trailing, 8)
//                }
//            }
//            .frame(width: 350, height: 50)
//            .padding(.horizontal, 40)
//            .padding(.top, 10)
//
//            // Gender buttons
//            VStack(spacing: 16) {
//                ForEach(genders, id: \.self) { gender in
//                    Button(action: {
//                        selectedGender = gender
//                    }) {
//                        Text(gender)
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 50)
//                            .background(
//                                selectedGender == gender ? Color(red: 0.996, green: 0.961, blue: 0.922) : Color.white
//                            )
//                            .foregroundColor(selectedGender == gender ? .black : Color.gray)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(
//                                        selectedGender == gender ? Color(red: 0.631, green: 0.384, blue: 0.192) : Color.gray,
//                                        lineWidth: 1
//                                    )
//                            )
//                            .cornerRadius(8)
//                    }
//                }
//            }
//            .padding(.horizontal, 40)
//            .onAppear {
//                // Set gender and year
//                switch userViewModel.user.gender {
//                case .male: selectedGender = "Male"
//                case .female: selectedGender = "Female"
//                case .other: selectedGender = "Non Binary"
//                }
//
//                let currentYear = Calendar.current.component(.year, from: Date())
//                let birthYearFromAge = currentYear - userViewModel.user.age
//                selectedYear = String(birthYearFromAge)
//
//                livesWithKids = userViewModel.user.preferences.goodWithKids
//                livesWithDogs = userViewModel.user.preferences.goodWithOtherDogs
//            }
//
//            // Birth Year picker
//            VStack(spacing: 8) {
//                Text("What's your birth year?")
//                    .font(.system(size: 24, weight: .semibold))
//                    .foregroundColor(.primary)
//
//                Button(action: {
//                    showPicker.toggle()
//                }) {
//                    Text(selectedYear == "2025" ? "Select Year" : selectedYear)
//                        .foregroundColor(selectedYear == "2025" ? Color(hex: "999999") : .primary)
//                        .frame(width: 350, height: 50)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color(hex: "999999"), lineWidth: 1)
//                        )
//                }
//
//                if showPicker {
//                    Picker("Birthyear", selection: $selectedYear) {
//                        ForEach(years, id: \.self) { year in
//                            Text(year).tag(year)
//                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    .frame(height: 150)
//                }
//            }
//            .padding(.top, 20)
//
//            // Kids and Dogs at home
//            VStack(alignment: .leading, spacing: 24) {
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Any kids at home?")
//                        .font(.system(size: 24, weight: .semibold))
//                        .foregroundColor(.primary)
//
//                    yesNoButtons(selected: $livesWithKids)
//                }
//
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Any dogs at home?")
//                        .font(.system(size: 24, weight: .semibold))
//                        .foregroundColor(.primary)
//
//                    yesNoButtons(selected: $livesWithDogs)
//                }
//            }
//            .padding(.horizontal, 40) // ← this applies to all children
//
//
//            Spacer()
//
//            // Save Button
//            Button(action: {
//                saveChanges()
//                presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("Save")
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
//        .navigationBarBackButtonHidden()
//    }
//
//    private var isFormComplete: Bool {
//        !nameInput.trimmingCharacters(in: .whitespaces).isEmpty &&
//        selectedGender != nil &&
//        selectedYear != "2025" &&
//        livesWithKids != nil &&
//        livesWithDogs != nil
//    }
//
//    private func saveChanges() {
//        let genderEnum: HumanGender
//        switch selectedGender {
//        case "Male": genderEnum = .male
//        case "Female": genderEnum = .female
//        case "Non Binary": genderEnum = .other
//        default: genderEnum = .other
//        }
//
//        let currentYear = Calendar.current.component(.year, from: Date())
//        let birthYearInt = Int(selectedYear) ?? (currentYear - userViewModel.user.age)
//        let age = max(currentYear - birthYearInt, 0)
//
//        let current = userViewModel.user
//
//        let updatedPreferences = UserPreferences(
//            preferredBreeds: current.preferences.preferredBreeds,
//            sizePreferences: current.preferences.sizePreferences,
//            genderPreferences: current.preferences.genderPreferences,
//            activityLevels: current.preferences.activityLevels,
//            goodWithKids: livesWithKids ?? false,
//            goodWithOtherDogs: livesWithDogs ?? false,
//            personalityPreferences: current.preferences.personalityPreferences,
//            preferredRadius: current.preferences.preferredRadius
//        )
//
//
//
//        let updatedUser = UserProfile(
//            id: current.id,
//            name: nameInput.isEmpty ? current.name : nameInput,
//            gender: genderEnum,
//            age: age,
//            location: current.location,
//            preferences: updatedPreferences
//        )
//
//        userViewModel.updateUserProfile(updatedUser)
//    }
//
//    // MARK: - Yes/No Buttons
//    func yesNoButtons(selected: Binding<Bool?>) -> some View {
//        HStack(spacing: 16) {
//            Button(action: { selected.wrappedValue = true }) {
//                Text("Yes")
//                    .fontWeight(.medium)
//                    .frame(maxWidth: .infinity, maxHeight: 44)
//                    .background(selected.wrappedValue == true ? Color(hex: "F8EEDF") : Color.white)
//                    .foregroundColor(selected.wrappedValue == true ? .primary : .gray)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(selected.wrappedValue == true ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
//                    )
//                    .cornerRadius(12)
//            }
//
//            Button(action: { selected.wrappedValue = false }) {
//                Text("No")
//                    .fontWeight(.medium)
//                    .frame(maxWidth: .infinity, maxHeight: 44)
//                    .background(selected.wrappedValue == false ? Color(hex: "F8EEDF") : Color.white)
//                    .foregroundColor(selected.wrappedValue == false ? .primary : .gray)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(selected.wrappedValue == false ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
//                    )
//                    .cornerRadius(12)
//            }
//        }
//    }
//}
//
//

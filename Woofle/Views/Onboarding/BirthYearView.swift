//
//  PreferredGenderView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

import SwiftUI

struct BirthYearView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    let years: [String] = Array(1900...Calendar.current.component(.year, from: Date()))
        .reversed()
        .map { String($0) }

    @State private var selectedYear: String = "2025"
    @State private var showPicker = false
    @State private var navigateToNext = false

    var body: some View {
        VStack(spacing: 20) {
            // Header with centered title and back button
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

            // Progress Bar
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)

                        if index < 1 {
                            Capsule()
                                .fill(Color(hex: "F8CE9B"))
                                .frame(height: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)

            // Title
            Text("What's your birth year?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)

            // Custom input field
            Button(action: {
                showPicker.toggle()
            }) {
                Text(selectedYear)
                    .foregroundColor(selectedYear == "2025" ? Color(hex: "999999") : .black)
                    .frame(width: 350, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(hex: "999999"), lineWidth: 1)
                    )
            }

            // Picker (overlay only when active)
            if showPicker {
                Picker("Birthyear", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(year).tag(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
            }

            Spacer()

            // Disclaimer
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "questionmark.circle.fill")
                    .foregroundColor(Color(hex: "B8B8B8"))
                    .font(.system(size: 18))

                Text("This helps us suggest dogs that better match your lifestyle.")
                    .foregroundColor(Color(hex: "B8B8B8"))
                    .font(.system(size: 15))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            // Next Button
            Button(action: {
                userViewModel.updateBirthYear(selectedYear)
                navigateToNext = true
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedYear == "2025" ? Color(hex: "D6D6D6") : Color(hex: "A3B18A"))
                    .foregroundColor(selectedYear == "2025" ? Color(hex: "999999") : .white)
                    .cornerRadius(10)
            }
            .disabled(selectedYear == "2025")
            .padding(.horizontal)
            .padding(.bottom, 40)

            NavigationLink(destination: GenderSelectionView(), isActive: $navigateToNext) {
                EmptyView()
            }
            .hidden()
            .navigationBarBackButtonHidden()
        }
    }
}

struct BirthYearView_Previews: PreviewProvider {
    static var previews: some View {
        BirthYearView()
            .environmentObject(UserViewModel())
    }
}



//
//  DogGenderSizeView.swift
//  Woofle
//
//  Created by Rahel on 30/05/25.
//



//
//  DogGenderSizeView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//


    import SwiftUI

    struct DogGenderSizeView: View {
        @Environment(\.presentationMode) var presentationMode

        @State private var selectedGender: String? = nil
        @State private var selectedSizes: Set<String> = []

        let sizes = ["Small", "Middle", "High"]

        var body: some View {
            VStack(spacing: 20) {

                // Top Nav
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 20, weight: .medium))
                    }

                    Spacer()

                    Text("About your dog")
                        .font(.headline)
                        .foregroundColor(.black)

                    Spacer()

                    NavigationLink(destination: StartTournamentView()) {
                        Text("Skip")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .fontWeight(.medium)
                    }
                }
                .padding(.horizontal)

                // Progress bar (5 steps)
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
                        genderButton(title: "Female")
                        genderButton(title: "Male")
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

                // Next button
                NavigationLink(destination: StartTournamentView()) {
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
            }
            .padding(.top, 30)
            .background(Color.white)
        }

        // MARK: - Gender Button
        func genderButton(title: String) -> some View {
            Button(action: {
                selectedGender = selectedGender == title ? nil : title
            }) {
                Text(title)
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

        // MARK: - Size Selectable Row
        func sizeSelectableRow(title: String) -> some View {
            Button(action: {
                if selectedSizes.contains(title) {
                    selectedSizes.remove(title)
                } else {
                    selectedSizes.insert(title)
                }
            }) {
                HStack {
                    Spacer()
                    
                    Text(title)
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


#Preview {
    DogGenderSizeView()
}

//
//  PersonalityPreferenceView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

import SwiftUI


    struct PersonalityPreferenceView: View {
        @Environment(\.presentationMode) var presentationMode
        @State private var selectedTraits: Set<String> = []

        let traits = ["Playful", "Calm", "Curious", "Affectionate", "Protective", "Independent"]

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
                        .foregroundColor(.black)

                    Spacer()

                    NavigationLink(destination: HomePageStartTournament()) {
                        Text("Skip")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .fontWeight(.medium)
                    }
                }
                .padding(.horizontal)

                // Progress bar (3 of 5 filled)
                HStack(spacing: 8) {
                    ForEach(0..<5) { index in
                        ZStack {
                            Capsule()
                                .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                                .frame(height: 10)

                            if index < 3 {
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
                    Text("Select personality traits:")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.black)

                    ForEach(traits, id: \.self) { trait in
                        traitSelectableRow(title: trait)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Always-enabled Next button
                NavigationLink(destination: HomePageStartTournament()) {
                    Text("Next")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "A0B58E"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .padding(.top, 30)
            .background(Color.white)
        }

        // MARK: - Trait Row
        func traitSelectableRow(title: String) -> some View {
            Button(action: {
                if selectedTraits.contains(title) {
                    selectedTraits.remove(title)
                } else {
                    selectedTraits.insert(title)
                }
            }) {
                HStack {
                    Text(title)
                        .foregroundColor(selectedTraits.contains(title) ? .black : .gray)
                        .frame(maxWidth: .infinity, alignment: .center)

                    ZStack {
                        Circle()
                            .stroke(selectedTraits.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                            .frame(width: 24, height: 24)

                        if selectedTraits.contains(title) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(hex: "B67A4B"))
                                .font(.system(size: 12, weight: .bold))
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedTraits.contains(title) ? Color(hex: "F8EEDF") : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(selectedTraits.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
                )
                .cornerRadius(12)
            }
        }
    }

   

#Preview {
    PersonalityPreferenceView()
}



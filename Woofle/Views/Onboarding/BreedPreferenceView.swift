//
//  BreedPreferenceView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

import SwiftUI


struct BreedPreferenceView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedBreeds: Set<String> = []

    let breeds = [
        "Golden Retriever",
        "Labrador Retriever",
        "Pomeranian",
        "Shih Tzu",
        "German Shepherd",
        "Bulldog",
        "Siberian Husky",
        "Chihuahua",
        "Dachshund"
    ]

    var body: some View {
        VStack(spacing: 8) {

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

            // Progress Bar (4 of 5 filled)
            HStack(spacing: 8) {
                ForEach(0..<5) { index in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)

                        if index < 4 {
                            Capsule()
                                .fill(Color(hex: "F8CE9B"))
                                .frame(height: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 10)

            // Question & Breed List
            VStack(alignment: .leading, spacing: 12) {
                Text("Choose breeds you like:")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)

                ForEach(breeds, id: \.self) { breed in
                    breedSelectableRow(title: breed)
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)

            // Always-enabled Next button
            NavigationLink(destination: StartTournamentView()) {
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

    // MARK: - Breed Row
    func breedSelectableRow(title: String) -> some View {
        Button(action: {
            if selectedBreeds.contains(title) {
                selectedBreeds.remove(title)
            } else {
                selectedBreeds.insert(title)
            }
        }) {
            HStack {
                Text(title)
                    .foregroundColor(selectedBreeds.contains(title) ? .black : .gray)
                    .frame(maxWidth: .infinity, alignment: .center)

                ZStack {
                    Circle()
                        .stroke(selectedBreeds.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if selectedBreeds.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedBreeds.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedBreeds.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
}

#Preview {
    NavigationView {
        BreedPreferenceView()
    }
}

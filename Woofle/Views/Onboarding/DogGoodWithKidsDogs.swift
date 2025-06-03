//
//  DogGoodWithKidsDogs.swift
//  Woofle
//
//  Created by Rahel on 30/05/25.
//


import SwiftUI

struct DogGoodWithKidsDogs: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var selectedOptions: Set<String> = []

    let options = ["Good with kids", "Good with other dogs"]

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

            // Progress bar (5 of 5 filled with stroke)
            HStack(spacing: 8) {
                ForEach(0..<5) { _ in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)

                        Capsule()
                            .fill(Color(hex: "F8CE9B"))
                            .frame(height: 10)
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)

            // Question
            VStack(alignment: .leading, spacing: 12) {
                Text("The dog should be:")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)

                ForEach(options, id: \.self) { option in
                    selectableRow(title: option)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Always-active Next button
            NavigationLink(destination: TabBarView()) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "A0B58E"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .simultaneousGesture(TapGesture().onEnded {
                let goodWithKids = selectedOptions.contains("Good with kids")
                let goodWithOtherDogs = selectedOptions.contains("Good with other dogs")

                userViewModel.updateGoodWithKids(goodWithKids)
                userViewModel.updateGoodWithOtherDogs(goodWithOtherDogs)
                userViewModel.completeOnboarding()
            })
            .padding(.horizontal)
            .padding(.bottom, 40)
            .navigationBarBackButtonHidden()
        }
        .padding(.top, 30)
    }

    // MARK: - Selectable Row
    func selectableRow(title: String) -> some View {
        Button(action: {
            if selectedOptions.contains(title) {
                selectedOptions.remove(title)
            } else {
                selectedOptions.insert(title)
            }
        }) {
            HStack {
                Text(title.capitalized)
                    .foregroundColor(selectedOptions.contains(title) ? .black : .gray)
                    .frame(maxWidth: .infinity, alignment: .center)

                ZStack {
                    Circle()
                        .stroke(selectedOptions.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if selectedOptions.contains(title) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "B67A4B"))
                            .font(.system(size: 12, weight: .bold))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedOptions.contains(title) ? Color(hex: "F8EEDF") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedOptions.contains(title) ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
}

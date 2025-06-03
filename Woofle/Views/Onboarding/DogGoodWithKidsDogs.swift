//////
//////  DogGoodWithKidsDogs.swift
//////  Woofle
//////
//////  Created by Rahel on 30/05/25.
//////
////
//
//

import SwiftUI

struct DogGoodWithKidsDogs: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var livesWithKids: Bool? = nil
    @State private var livesWithDogs: Bool? = nil
    @State private var navigateToNext = false

    var body: some View {
        NavigationStack {  // NavigationStack statt nur VStack
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
                }
                .padding(.horizontal)

                // Progress bar (4 of 4 filled with stroke)
                HStack(spacing: 8) {
                    ForEach(0..<4) { _ in
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

                // Questions
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Any kids at home?")
                            .font(.system(size: 20, weight: .semibold))

                        yesNoButtons(selected: $livesWithKids)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Any dogs at home?")
                            .font(.system(size: 20, weight: .semibold))

                        yesNoButtons(selected: $livesWithDogs)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Next Button
                Button(action: {
                    if let kids = livesWithKids, let dogs = livesWithDogs {
                        userViewModel.updateGoodWithKids(kids)
                        userViewModel.updateGoodWithOtherDogs(dogs)
                        navigateToNext = true
                    }
                }) {
                    Text("Next")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            (livesWithKids != nil && livesWithDogs != nil)
                            ? Color(hex: "A0B58E")
                            : Color.gray.opacity(0.5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(livesWithKids == nil || livesWithDogs == nil)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .padding(.top, 30)
            .background(Color.white)
            .navigationBarBackButtonHidden()

            // NAvigation to DogGenderSizeView
            .navigationDestination(isPresented: $navigateToNext) {
                DogGenderSizeView()
            }
        }
        .padding(.top, 30)
    }

    // MARK: - Yes/No buttons
    func yesNoButtons(selected: Binding<Bool?>) -> some View {
        HStack(spacing: 16) {
            Button(action: {
                selected.wrappedValue = true
            }) {
                Text("Yes")
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(selected.wrappedValue == true ? Color(hex: "F8EEDF") : Color.white)
                    .foregroundColor(selected.wrappedValue == true ? .primary : .gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selected.wrappedValue == true ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
                    )
                    .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())

            Button(action: {
                selected.wrappedValue = false
            }) {
                Text("No")
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(selected.wrappedValue == false ? Color(hex: "F8EEDF") : Color.white)
                    .foregroundColor(selected.wrappedValue == false ? .primary : .gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selected.wrappedValue == false ? Color(hex: "B67A4B") : Color.gray, lineWidth: 1)
                    )
                    .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}



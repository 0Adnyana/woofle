//
//  DogMatchCard.swift
//  Woofle
//
//  Created by Jesse Brown on 31/5/2025.
//

import Foundation

import SwiftUI

struct DogCard: View {
    let dog: Dog
    let shelter: Shelter
    let onSelect: () -> Void

    @State private var showDetails = false

    var body: some View {
        Button(action: onSelect) {
            // Dog card
            VStack(spacing: 0) {
                Image(dog.pictureURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(20, corners: [.topLeft, .topRight])

                HStack {
                    Text("\(dog.name.capitalized) • \(getYearsfromMonth(for: dog.ageInMonths)) • \(dog.gender.rawValue.capitalized)")
                        .foregroundColor(.primary)
                        .font(.body)

                    Spacer()

                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundColor(Color(hex: "A3B18A"))
                        .onTapGesture {
                            showDetails.toggle()
                        }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            }
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.bottom, 20)
            .frame(width: 375)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showDetails) {
            DogDetailView(dog: dog, shelter: shelter) {
                // Optional: directions handler
            }
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(25)
        }
    }
}



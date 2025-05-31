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
    let onTap: () -> Void
    let onInfoTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                Image(dog.pictureURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(20, corners: [.topLeft, .topRight])

                HStack {
                    Text("\(dog.name.capitalized) • \(getYearsfromMonth(for: dog.ageInMonths)) • \(dog.gender.rawValue.capitalized)")
                        .font(.body)
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundColor(Color.green)
                        .onTapGesture(perform: onInfoTap)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 3)
        }
    }
}

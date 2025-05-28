//
//  TournamentView.swift
//  Woofle
//
//  Created by Jesse Brown on 22/5/2025.
//

import SwiftUI

struct TournamentView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Header
            Text("Round 1")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)

            // First Dog Card
            DogCardView(
                image: Image("Dog-eg.1"),
                name: "Bella",
                age: "3 Years",
                gender: "Female",
                isSelected: true
            )

            // VS
            HStack {
                Image("VS")
                .resizable()
                .scaledToFit()
                .frame(width: 293, height: 70)
            }
            .padding(.horizontal)

            // Second Dog Card
            DogCardView(
                image: Image("Dog-eg.2"),
                name: "Bello",
                age: "5 Years",
                gender: "Male",
                isSelected: true
            )

            Spacer()
        }
        .padding()
    }
}

struct DogCardView: View {
    var image: Image
    var name: String
    var age: String
    var gender: String
    var isSelected: Bool

    var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 225)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(20, corners: [.topLeft, .topRight])

            HStack {
                Text("\(name) • \(age) • \(gender)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

// Helper to apply corner radius only to top corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    TournamentView()
}

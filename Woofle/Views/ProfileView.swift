//
//  ProfileView.swift
//  Woofle
//
//  Created by Rahel on 23/05/25.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var name: String = "James"
    @State private var selectedAgeRange: String? = "36 – 55"
    @State private var selectedActivity: String? = "Walks once a day"
    @State private var selectedHomeEnvironment: String? = "Farm/rural"
    @State private var location: String = ""
    
    let ageRanges = ["18 – 35", "36 – 55", "56 – 70", "> 70"]
    let activities = ["Couch Potato", "Walks once a day", "Very active/outdoorsy"]
    let environments = ["House", "House with garden", "Flat", "Farm/rural"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Image + Name
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "camera.fill")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 8) {
                        Text(name)
                            .font(.title2)
                            .bold()
                        Button(action: {
                            // Future: edit name
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.gray)
                        }
                    }
                }

                Divider()
                
                // Age Range
                SectionView(title: "Age Range") {
                    ChipSelector(options: ageRanges, selection: $selectedAgeRange)
                }
                
                // Location Field
                SectionView(title: "Location") {
                    TextField("Enter location", text: $location)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // Activity Level
                SectionView(title: "Activity Level") {
                    ChipSelector(options: activities, selection: $selectedActivity)
                }
                
                // Home Environment
                SectionView(title: "Home Environment") {
                    ChipSelector(options: environments, selection: $selectedHomeEnvironment)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("My Profile")
    }
}

// MARK: - Reusable Section View
struct SectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content
        }
    }
}

// MARK: - Reusable Chip Selector
struct ChipSelector: View {
    let options: [String]
    @Binding var selection: String?

    var body: some View {
        FlowLayout(spacing: 10) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selection = option
                }) {
                    Text(option)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selection == option ? Color.orange : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .foregroundColor(.black)
                        .cornerRadius(16)
                }
            }
        }
    }
}

// MARK: - Simple FlowLayout for horizontal wrapping
//struct FlowLayout<Content: View>: View {
//    let spacing: CGFloat
//    let content: () -> Content
//    
//    init(spacing: CGFloat = 8, @ViewBuilder content: @escaping () -> Content) {
//        self.spacing = spacing
//        self.content = content
//    }
//    
//    var body: some View {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: spacing)], spacing: spacing) {
//            content()
//        }
//    }
//}

#Preview {
    ProfileView()
}

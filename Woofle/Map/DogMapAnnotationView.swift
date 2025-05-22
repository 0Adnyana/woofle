//
//  DogMapAnnotationView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 21/05/25.
//

import Foundation
import SwiftUI
import MapKit

// Custom Map Annotation View
struct DogMapAnnotationView: View {
    let dog: Dog
    @State private var showDetails = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom dog icon
            ZStack {
                Image("dogIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 43, height: 33)
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
            }
            .scaleEffect(showDetails ? 1.2 : 1.0)
            .animation(.spring(), value: showDetails)
            
            // Dog name label
            Text(dog.name)
                .font(.caption)
                .fontWeight(.bold)
                .padding(4)
                .background(Color.white.opacity(0.8))
                .cornerRadius(4)
                .shadow(radius: 2)
        }
        .onTapGesture {
            showDetails.toggle()
        }
        .sheet(isPresented: $showDetails) {
            DogDetailView(dog: dog)
        }
    }
}


#Preview {
    DogMapAnnotationView()
}

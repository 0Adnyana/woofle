//
//  DogDetailRowView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 22/05/25.
//

import Foundation
import SwiftUI

// Helper view for detail rows
struct DogDetailRowView: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "A3B18A"))
                .frame(width: 25)
            Text(text)
            Spacer()
        }
    }
}


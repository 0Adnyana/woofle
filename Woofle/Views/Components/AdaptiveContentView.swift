//
//  AdaptiveContentView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 30/05/25.
//
import SwiftUI

struct AdaptiveContentView<Content: View>: View {
    let height: CGFloat
    let content: () -> Content
    
    var body: some View {
        let threshold: CGFloat = 700 // Customize this threshold as needed
        Group {
            if height < threshold {
                ScrollView {
                    content()
                }
            } else {
                content()
            }
        }
    }
}

//
//  FrameAnimator.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 29/05/25.
//


import SwiftUI

struct FrameAnimator: View {
    let frames: [UIImage]
    @State private var index = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        Image(uiImage: frames[index])
            .resizable()
            .scaledToFit()
            .onReceive(timer) { _ in
                index = (index + 1) % frames.count
            }
    }
}
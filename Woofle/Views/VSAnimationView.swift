import SwiftUI

struct VSAnimationView: View {
    @State private var scale: CGFloat = 0.1
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 150, height: 150)
                    .background(
                        Image("dog1")
                            .resizable()
                            .clipShape(.circle)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .overlay(
                        Circle()
                            .inset(by: -1.5)
                            .stroke(Color(red: 0.64, green: 0.69, blue: 0.54).opacity(0.8), lineWidth: 4)
                    )
                    .padding()

                Image("versus")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .scaleEffect(scale)
                
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 150, height: 150)
                    .background(
                        Image("dog2")
                            .resizable()
                            .clipShape(.circle)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .overlay(
                        Circle()
                            .inset(by: -1.5)
                            .stroke(Color(red: 0.64, green: 0.69, blue: 0.54).opacity(0.8), lineWidth: 4)
                    )
                    .padding()

            }
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    scale = 1.5
                    opacity = 1
                }
            }
        }
    }
}
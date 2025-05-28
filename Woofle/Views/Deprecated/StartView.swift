//
//  ContentView.swift
//  Woofle_App_CH2
//
//  Created by Rahel on 20/05/25.
//

import SwiftUI

struct StartView: View {
    @State private var inputText: String = ""
    
    @State private var navigateToCharacterView = false


    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(hex: "FFFFFF")
                    .ignoresSafeArea()
                
                VStack {
                    Text("Adopt Your New Best Friend.")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(Color(hex: "B67A4B"))
                    
                    ZStack {
                        Circle()
                            .fill(Color(hex: "A3B18A"))
                            .frame(width: 280, height: 280) // Circle size
                        
                        Image("Woofle_01")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 290, height: 290) // Image size
                            .clipShape(Circle())
                    }
                    Text("Welcome to Woofle!")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(Color(hex: "B67A4B"))
                        .padding(.top, 20)  // etwas Abstand nach oben
                    
                    // TextField mit grünem Rand und abgerundeten Ecken!!!...
                    TextField("Input Your Name", text: $inputText)
                        .padding(.horizontal, 15)
                        .frame(width: 316, height: 44)
                        .background(Color(hex: "FFFFFF"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hex: "A3B18A"), lineWidth: 2)
                        )
                        .padding(.top, 20)
                    
                                    NavigationLink(
                                        destination: CharacterSelectionView(),
                                        isActive: $navigateToCharacterView,
                                        label: {
                                            EmptyView()
                                        }
                                    )
                    
                    
                    
                    Button(action: {
                        navigateToCharacterView = true
                    }) {
                        Text("Continue")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .frame(width: 316, height: 44)
                            .background(inputText.isEmpty ? Color.white : Color(hex: "F8CE9C"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(15)
                    }
                    .disabled(inputText.isEmpty)
                    .padding(.top, 20)

                    
                    
                }
                .padding(20)
                .offset(y: 10)
            }
        }
    }
}

#Preview {
    StartView()
}

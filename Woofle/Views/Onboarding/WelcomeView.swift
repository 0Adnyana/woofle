//
//  PreferredGenderView.swift
//  Woofle
//
//  Created by Rahel on 29/05/25.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var nameInput: String = ""
    @State private var navigateToNext = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("Adopt Your New Best Friend.")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                ZStack {
                    Circle()
                        .fill(Color(hex: "A3B18A"))
                        .frame(width: 280, height: 280)

                    Image("Woofle_01")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 290, height: 290)
                        .clipShape(Circle())
                }

                Text("Welcome to Woofle!")
                    .font(.title2)
                    .fontWeight(.semibold)

                ZStack(alignment: .trailing) {
                    TextField("Your Name", text: $nameInput)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        .submitLabel(.done)
                        .onSubmit {
                            if !nameInput.isEmpty {
                                let existingUser = userViewModel.user
                                let updatedUser = UserProfile(
                                    id: existingUser.id,
                                    name: nameInput,
                                    gender: existingUser.gender,
                                    age: existingUser.age,
                                    location: existingUser.location,
                                    preferences: existingUser.preferences
                                )
                                userViewModel.update(updatedUser)
                                navigateToNext = true
                            }
                        }

                    if !nameInput.isEmpty {
                        Button(action: {
                            let existingUser = userViewModel.user
                            let updatedUser = UserProfile(
                                id: existingUser.id,
                                name: nameInput,
                                gender: existingUser.gender,
                                age: existingUser.age,
                                location: existingUser.location,
                                preferences: existingUser.preferences
                            )
                            userViewModel.update(updatedUser)
                            navigateToNext = true
                        }) {
                            Image(systemName: "arrow.turn.down.left")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .padding(.trailing, 8)
                    }
                }
                .frame(width: 350, height: 50)
                .padding(.horizontal, 40)
                .padding(.top, 10)

                Spacer()

                NavigationLink(destination: BirthYearView(), isActive: $navigateToNext) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(UserViewModel())
    }
}


//import SwiftUI
//
//struct WelcomeView: View {
//    @State private var nameInput: String = ""
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Spacer()
//
//            Text("Adopt Your New Best Friend.")
//                .font(.title2)
//                .fontWeight(.semibold)
//                .multilineTextAlignment(.center)
//
//            ZStack {
//                Circle()
//                    .fill(Color(hex: "A3B18A"))
//                    .frame(width: 280, height: 280)
//
//                Image("Woofle_01")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 290, height: 290)
//                    .clipShape(Circle())
//            }
//
//            Text("Welcome to Woofle!")
//                .font(.title2)
//                .fontWeight(.semibold)
//
//            ZStack(alignment: .trailing) {
//                TextField("Your Name", text: $nameInput)
//                    .padding()
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(15)
//                    .submitLabel(.done)
//                    .onSubmit {
//                        // Action when submit pressed, e.g., validate or navigate
//                    }
//
//                if !nameInput.isEmpty {
//                    Button(action: {
//                        // Action when button pressed, e.g., validate or navigate
//                    }) {
//                        Image(systemName: "arrow.turn.down.left")
//                            .foregroundColor(.black)
//                            .padding()
//                    }
//                    .padding(.trailing, 8)
//                }
//            }
//            .frame(width: 350, height: 50)
//            .padding(.horizontal, 40)
//            .padding(.top, 10)
//
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeView()
//    }
//}

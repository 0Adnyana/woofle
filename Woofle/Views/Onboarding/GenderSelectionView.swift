import SwiftUI

struct GenderSelectionView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedGender: String? = nil

    let genders = ["Female", "Male", "Non Binary"]

    var body: some View {
        VStack(spacing: 20) {
            // Header with back button and centered title
            ZStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.brown)
                            .font(.system(size: 20, weight: .medium))
                    }
                    Spacer()
                }

                Text("About you")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)

            // Progress bar (2 of 3 filled)
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    ZStack {
                        Capsule()
                            .stroke(Color(hex: "B67A4B"), lineWidth: 2)
                            .frame(height: 10)

                        if index < 2 {
                            Capsule()
                                .fill(Color(hex: "F8CE9B"))
                                .frame(height: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 5)

            // Title
            Text("What's your gender?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)

            // Gender buttons
            VStack(spacing: 16) {
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        selectedGender = gender
                    }) {
                        Text(gender)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                selectedGender == gender ? Color(red: 0.996, green: 0.961, blue: 0.922) : Color.white
                            )
                            .foregroundColor(selectedGender == gender ? .black : Color.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        selectedGender == gender ? Color(red: 0.631, green: 0.384, blue: 0.192) : Color.gray,
                                        lineWidth: 1
                                    )
                            )
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
            
            //disclaimer
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "questionmark.circle.fill")
                    .foregroundColor(Color(hex: "D6D6D6")) // Light gray
                    .font(.system(size: 18))

                Text("Some dogs feel safer with certain genders. This helps us make the best match for both of you.")
                    .foregroundColor(Color(hex: "D6D6D6"))
                    .font(.system(size: 15))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)


            // Next button
            Button(action: {
                // Save selectedGender to your model here
                print("Selected gender: \(selectedGender ?? "")")
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedGender == nil ? Color.gray.opacity(0.3) : Color(hex: "A3B18A"))
                    .foregroundColor(selectedGender == nil ? Color.gray : .white)
                    .cornerRadius(10)
            }
            .disabled(selectedGender == nil)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .padding(.top, 30) // To avoid notch overlap
        .background(Color.white)
    }
}

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView()
    }
}

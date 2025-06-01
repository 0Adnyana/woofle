//import SwiftUI
//
//struct CharacterSelectionView: View {
//    
//    @StateObject private var locationManager = LocationManager()
//    @State private var selectedAge: Double = 25
//    @State private var selectedGender: HumanGender? = nil
////    @State private var selectedActivity: EnergyLevel? = nil
////    @State private var selectedHome: String? = nil
////    @State private var selectedWorkSchedule: String? = nil
////    @State private var selectedOtherPets: String? = nil
//    @State private var selectedDogSize: Set<Size> = []
//    @State private var selectedDogGender: DogGender? = nil
//    @State private var selectedEnergyLevel: Set<EnergyLevel> = []
//    @State private var selectedGoodWithKids: Bool? = nil
//    @State private var selectedGoodWithOtherDogs: Bool? = nil
//    @State private var selectedPersonalityTraits: Set<PersonalityTrait> = []
////    @State private var selectedSpecialNeeds: String? = nil
//    @State private var selectedPreferredRadius: Double = 25
//    @State private var showNext = false
//    
//    @State private var navigateToHome = false
//
//    // Static options that don't have enums
////    let homeEnvironments = ["House", "House with garden", "Flat", "Farm / rural"]
////    let workSchedules = ["Home most of the time", "Regular 9 - 5", "Night shift / irregular"]
//    let otherPetOptions = ["Yes", "No"]
//    let specialNeedsOptions = ["Yes", "No", "Maybe"]
//    let breeds = [
//        "Golden Retriever", "Labrador Retriever", "Beagle", "Pomeranian",
//        "Shih Tzu", "German Shepherd", "Bulldog", "Siberian Husky",
//        "Chihuahua", "Dachshund"
//    ]
//    
//    var canContinue: Bool {
//        selectedGender != nil &&
////        selectedActivity != nil &&
////        selectedHome != nil &&
////        selectedWorkSchedule != nil &&
////        selectedOtherPets != nil &&
//        !selectedDogSize.isEmpty &&
//        selectedDogGender != nil &&
//        !selectedEnergyLevel.isEmpty &&
//        selectedGoodWithKids != nil &&
//        selectedGoodWithOtherDogs != nil &&
//        !selectedPersonalityTraits.isEmpty
////        selectedSpecialNeeds != nil
//    }
//    
//    private var authorizationStatusText: String {
//        switch locationManager.authorizationStatus {
//        case .notDetermined: return "Not Determined"
//        case .restricted: return "Restricted"
//        case .denied: return "Denied"
//        case .authorizedAlways: return "Authorized Always"
//        case .authorizedWhenInUse: return "Authorized When In Use"
//        @unknown default: return "Unknown"
//        }
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 24) {
//                    Text("Who are you?")
//                        .font(.system(size: 32))
//                        .foregroundColor(.black)
//                        .padding(.top, 10)
//                    
//                    // Age Slider Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Divider().background(Color.black)
//                        
//                        Text("Your Age: \(Int(selectedAge))")
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                        
//                        Slider(value: $selectedAge, in: 18...80, step: 1)
//                            .accentColor(Color(hex: "F8CE9C"))
//                    }
//                    
//                    // Gender Section
//                    enumSection("Your Gender", options: HumanGender.self, selection: $selectedGender) { gender in
//                        gender.rawValue.capitalized
//                    }
//                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        Divider().background(Color.black)
//                        
//                        Text("Location")
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                        
//                        Button(action: {
//                            locationManager.requestLocation()
//                        }) {
//                            HStack {
//                                Image(systemName: "location.fill")
//                                Text("Update Location")
//                            }
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                            .padding()
//                            .background(
//                                locationManager.authorizationStatus == .authorizedWhenInUse ||
//                                locationManager.authorizationStatus == .authorizedAlways
//                                ? Color(hex: "F8CE9C") // Braun nach Erfolg
//                                : Color.white // Standard
//                            )
//                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
//                            .cornerRadius(15)
//                        }
//                        
//                        Text("Location: \(locationManager.currentLocation) — Status: \(authorizationStatusText)")
//                            .foregroundColor(.black.opacity(0.8))
//                            .font(.system(size: 16))
//                    }
//                    
////                    // Activity Level using EnergyLevel enum
////                    enumSection("Your Activity Level", options: EnergyLevel.self, selection: $selectedActivity) { level in
////                        switch level {
////                        case .low: return "Couch Potato"
////                        case .moderate: return "Walks once a day"
////                        case .high: return "Very active / outdoorsey"
////                        }
////                    }
////                    
////                    section("Home Environment", options: homeEnvironments, selection: $selectedHome)
////                    section("Work Schedule", options: workSchedules, selection: $selectedWorkSchedule)
////                    section("Other Pets", options: otherPetOptions, selection: $selectedOtherPets)
//                    
//                    // Preferred Search Radius Slider
//                    VStack(alignment: .leading, spacing: 10) {
//                        Divider().background(Color.black)
//                        
//                        Text("Search Radius: \(Int(selectedPreferredRadius)) km")
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                        
//                        Slider(value: $selectedPreferredRadius, in: 5...100, step: 5)
//                            .accentColor(Color(hex: "F8CE9C"))
//                    }
//                    
//                    Text("What are you looking for?")
//                        .font(.system(size: 32))
//                        .foregroundColor(.black)
//                        .padding(.top, 20)
//                    
//                    // Dog Size - Multi-select using Size enum
//                    enumMultiSelectSection("Dog Size", options: Size.self, selection: $selectedDogSize) { size in
//                        size.rawValue.capitalized
//                    }
//                    
//                    // Dog Gender using Gender enum
//                    enumSection("Dog Gender", options: DogGender.self, selection: $selectedDogGender) { gender in
//                        gender.rawValue.capitalized
//                    }
//                    
//                    // Energy Level - Multi-select
//                    enumMultiSelectSection("Energy Level", options: EnergyLevel.self, selection: $selectedEnergyLevel) { level in
//                        level.rawValue.capitalized
//                    }
//                    
//                    // Good with Kids
//                    boolSection("Good with Kids", selection: $selectedGoodWithKids)
//                    
//                    // Good with Other Dogs
//                    boolSection("Good with Other Dogs", selection: $selectedGoodWithOtherDogs)
//                    
//                    // Personality Traits - Multi-select
//                    enumMultiSelectSection("Personality Preferences", options: PersonalityTrait.self, selection: $selectedPersonalityTraits) { trait in
//                        trait.rawValue.capitalized
//                    }
//                    
////                    section("Open to Special Needs / Older Dogs", options: specialNeedsOptions, selection: $selectedSpecialNeeds)
//                    
//                    Button(action: {
//                        // Here you would save the user preferences
//                        saveUserPreferences()
//                        navigateToHome = true
//                    }) {
//                        Text("Save")
//                            .font(.system(size: 18))
//                            .foregroundColor(canContinue ? .black : .black)
//                            .frame(width: 316, height: 44)
//                            .background(canContinue ? Color(hex: "A3B18A") : Color.white)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 15)
//                                    .stroke(Color.black, lineWidth: 1)
//                            )
//                            .cornerRadius(15)
//                    }
//                    .disabled(!canContinue)
//                    .opacity(1)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(.top, 30)
//
//                    NavigationLink(
//                        destination: StartTournamentView(),
//                        isActive: $navigateToHome
//                    ) {
//                        EmptyView()
//                    }
//                }
//                .padding()
//                .background(Color.white)
//            }
//        }
//    }
//    
//    // MARK: - Save User Preferences
//    func saveUserPreferences() {
//        // Create UserPreferences object with collected data
//        let preferences = UserPreferences(
//            preferredBreeds: nil, // You can add breed selection if needed
//            sizePreferences: Array(selectedDogSize),
//            activityLevels: Array(selectedEnergyLevel),
//            goodWithKids: selectedGoodWithKids,
//            goodWithOtherDogs: selectedGoodWithOtherDogs,
//            personalityPreferences: Array(selectedPersonalityTraits),
//            preferredRadius: selectedPreferredRadius
//        )
//        
//        // Save to UserDefaults or Core Data
//        print("Saving user preferences: \(preferences)")
//    }
//    
//    // MARK: - Section with Dividers (String options)
//    func section(_ title: String, options: [String], selection: Binding<String?>) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Divider().background(Color.black)
//            
//            Text(title)
//                .font(.system(size: 16))
//                .foregroundColor(.black)
//            
//            FlowLayout(spacing: 10) {
//                ForEach(options, id: \.self) { option in
//                    Button(action: {
//                        selection.wrappedValue = option
//                    }) {
//                        Text(option)
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 10)
//                            .background(selection.wrappedValue == option ? Color(hex: "F8CE9C") : Color.white)
//                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
//                            .cornerRadius(15)
//                    }
//                }
//            }
//        }
//    }
//    
//    // MARK: - Enum Single Selection Section
//    func enumSection<T: CaseIterable & Hashable>(_ title: String, options: T.Type, selection: Binding<T?>, displayName: @escaping (T) -> String) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Divider().background(Color.black)
//            
//            Text(title)
//                .font(.system(size: 16))
//                .foregroundColor(.black)
//            
//            FlowLayout(spacing: 10) {
//                ForEach(Array(options.allCases), id: \.self) { option in
//                    Button(action: {
//                        selection.wrappedValue = option
//                    }) {
//                        Text(displayName(option))
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 10)
//                            .background(selection.wrappedValue == option ? Color(hex: "F8CE9C") : Color.white)
//                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
//                            .cornerRadius(15)
//                    }
//                }
//            }
//        }
//    }
//    
//    // MARK: - Enum Multi-select Section
//    func enumMultiSelectSection<T: CaseIterable & Hashable>(_ title: String, options: T.Type, selection: Binding<Set<T>>, displayName: @escaping (T) -> String) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Divider().background(Color.black)
//            
//            Text(title)
//                .font(.system(size: 16))
//                .foregroundColor(.black)
//            
//            FlowLayout(spacing: 10) {
//                ForEach(Array(options.allCases), id: \.self) { option in
//                    Button(action: {
//                        if selection.wrappedValue.contains(option) {
//                            selection.wrappedValue.remove(option)
//                        } else {
//                            selection.wrappedValue.insert(option)
//                        }
//                    }) {
//                        Text(displayName(option))
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 10)
//                            .background(selection.wrappedValue.contains(option) ? Color(hex: "F8CE9C") : Color.white)
//                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
//                            .cornerRadius(15)
//                    }
//                }
//            }
//        }
//    }
//    
//    // MARK: - Boolean Section (Yes/No)
//    func boolSection(_ title: String, selection: Binding<Bool?>) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Divider().background(Color.black)
//            
//            Text(title)
//                .font(.system(size: 16))
//                .foregroundColor(.black)
//            
//            FlowLayout(spacing: 10) {
//                ForEach(["Yes", "No"], id: \.self) { option in
//                    Button(action: {
//                        selection.wrappedValue = option == "Yes"
//                    }) {
//                        Text(option)
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 10)
//                            .background(
//                                (selection.wrappedValue == true && option == "Yes") ||
//                                (selection.wrappedValue == false && option == "No")
//                                ? Color(hex: "F8CE9C") : Color.white
//                            )
//                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
//                            .cornerRadius(15)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Flow Layout for wrapping buttons
//struct FlowLayout: Layout {
//    let spacing: CGFloat
//    
//    init(spacing: CGFloat = 8) {
//        self.spacing = spacing
//    }
//    
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let result = FlowResult(
//            in: proposal.replacingUnspecifiedDimensions().width,
//            subviews: subviews,
//            spacing: spacing
//        )
//        return result.bounds
//    }
//    
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        let result = FlowResult(
//            in: bounds.width,
//            subviews: subviews,
//            spacing: spacing
//        )
//        for (index, subview) in subviews.enumerated() {
//            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX,
//                                    y: bounds.minY + result.frames[index].minY),
//                         proposal: ProposedViewSize(result.frames[index].size))
//        }
//    }
//}
//
//struct FlowResult {
//    var bounds = CGSize.zero
//    var frames: [CGRect] = []
//    
//    init(in maxWidth: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
//        var origin = CGPoint.zero
//        var rowHeight: CGFloat = 0
//        
//        for subview in subviews {
//            let size = subview.sizeThatFits(.unspecified)
//            
//            if origin.x + size.width > maxWidth && origin.x > 0 {
//                // Move to next row
//                origin.x = 0
//                origin.y += rowHeight + spacing
//                rowHeight = 0
//            }
//            
//            frames.append(CGRect(origin: origin, size: size))
//            
//            // Update for next iteration
//            origin.x += size.width + spacing
//            rowHeight = max(rowHeight, size.height)
//        }
//        
//        bounds = CGSize(
//            width: maxWidth,
//            height: origin.y + rowHeight
//        )
//    }
//}
//
//#Preview {
//    CharacterSelectionView()
//}
//

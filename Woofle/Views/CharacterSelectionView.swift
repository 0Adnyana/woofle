//
//
//import SwiftUI
//
//struct CharacterSelectionView: View {
//    
//    @StateObject private var locationManager = LocationManager()
//    @State private var selectedAgeRange: String? = nil
//    @State private var selectedActivity: String? = nil
//    @State private var selectedHome: String? = nil
//    @State private var selectedWorkSchedule: String? = nil
//    @State private var selectedOtherPets: String? = nil
//    @State private var selectedDogSize: String? = nil
//    @State private var selectedGender: String? = nil
//    @State private var selectedEnergyLevel: String? = nil
//    @State private var selectedGoodWith: Set<String> = []
//    @State private var selectedTemperament: Set<String> = []
//    @State private var selectedSpecialNeeds: String? = nil
//    @State private var showNext = false
//    
//    @State private var navigateToHome = false
//
//    
//    let activityLevels = ["Couch Potato", "Walks once a day", "Very active / outdoorsey"]
//    let ageRanges = ["18-35", "36-55", "56-70", "> 70"]
//    let homeEnvironments = ["House", "House with garden", "Flat", "Farm / rural"]
//    let workSchedules = ["Home most of the time", "Regular 9 - 5", "Night shift / irregular"]
//    let otherPetOptions = ["Yes", "No"]
//    let dogSizes = ["Small", "Middle", "Large"]
//    let genders = ["Female", "Male"]
//    let energyLevels = ["Low", "Moderate", "High"]
//    let goodWithOptions = ["Other dogs", "Kids", "Cats"]
//    let temperamentOptions = ["Calm", "Playful", "Protective", "Goofy", "Affectionate"]
//    let specialNeedsOptions = ["Yes", "No", "Maybe"]
//    
//    var canContinue: Bool {
//        selectedAgeRange != nil &&
//        selectedActivity != nil &&
//        selectedHome != nil &&
//        selectedWorkSchedule != nil &&
//        selectedOtherPets != nil &&
//        selectedDogSize != nil &&
//        selectedGender != nil &&
//        selectedEnergyLevel != nil &&
//        !selectedGoodWith.isEmpty &&
//        !selectedTemperament.isEmpty &&
//        selectedSpecialNeeds != nil
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
//                    Text("Let your future dog get to know you…")
//                        .font(.system(size: 20))
//                        .foregroundColor(.black)
//                        .padding(.top, 10)
//                    
//                    section("Age Range", options: ageRanges, selection: $selectedAgeRange)
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
//                    section("Activity Level", options: activityLevels, selection: $selectedActivity)
//                    section("Home Environment", options: homeEnvironments, selection: $selectedHome)
//                    section("Work Schedule", options: workSchedules, selection: $selectedWorkSchedule)
//                    section("Other Pets", options: otherPetOptions, selection: $selectedOtherPets)
//                    
//                    Text("What you're looking for...")
//                        .font(.system(size: 20))
//                        .foregroundColor(.black)
//                        .padding(.top, 20)
//                    
//                    section("Dog Size", options: dogSizes, selection: $selectedDogSize)
//                    section("Gender", options: genders, selection: $selectedGender)
//                    section("Energy Level", options: energyLevels, selection: $selectedEnergyLevel)
//                    multiSelectSection("Good with", options: goodWithOptions, selection: $selectedGoodWith)
//                    multiSelectSection("Temperament Preferences", options: temperamentOptions, selection: $selectedTemperament)
//                    section("Open to Special Needs / Older Dogs", options: specialNeedsOptions, selection: $selectedSpecialNeeds)
//                    
//                    Button(action: {
//                        navigateToHome = true
//                    }) {
//                        Text("Adopt your Dog")
//                            .font(.system(size: 18, weight: .bold))
//                            .foregroundColor(.black)
//                            .frame(width: 316, height: 44)
//                            .background(canContinue ? Color(hex: "F8CE9C") : Color.gray.opacity(0.3))
//                            .cornerRadius(15)
//                    }
//                    .disabled(!canContinue)
//                    .opacity(canContinue ? 1 : 0.6)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(.top, 30)
//
//                    // Unsichtbarer NavigationLink (unter dem Button)
//                    NavigationLink(
//                        destination: HomePageStartTournament(),
//                        isActive: $navigateToHome
//                    ) {
//                        EmptyView()
//                    }
//
//
//                }
//                
//                
//                
//                .padding()
//                .background(Color.white)
//            }
////            .ignoresSafeArea(edges: .bottom)
//        }
//    }
//    
//    // MARK: - Section with Dividers
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
//    // MARK: - Multi-select Section for Good With and Temperament
//    func multiSelectSection(_ title: String, options: [String], selection: Binding<Set<String>>) -> some View {
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
//                        if selection.wrappedValue.contains(option) {
//                            selection.wrappedValue.remove(option)
//                        } else {
//                            selection.wrappedValue.insert(option)
//                        }
//                    }) {
//                        Text(option)
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

import SwiftUI

struct CharacterSelectionView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    // Statt String jetzt Enums als Selection, optional
    @State private var selectedAge: Double = 30 // Alter als Slider (z.B. 0 bis 100)
    @State private var selectedActivity: EnergyLevel? = nil
    @State private var selectedHome: String? = nil
    @State private var selectedWorkSchedule: String? = nil
    @State private var selectedOtherPets: String? = nil
    @State private var selectedDogSize: Size? = nil
    @State private var selectedGender: Gender? = nil
    @State private var selectedGoodWith: Set<String> = []
    @State private var selectedTemperament: Set<PersonalityTrait> = []
    @State private var selectedSpecialNeeds: String? = nil
    @State private var navigateToHome = false
    
    // Beispielwerte, kannst du auch aus JSON laden oder woanders her
    let ageRange = 0.0...100.0
    let homeEnvironments = ["House", "House with garden", "Flat", "Farm / rural"]
    let workSchedules = ["Home most of the time", "Regular 9 - 5", "Night shift / irregular"]
    let otherPetOptions = ["Yes", "No"]
    let goodWithOptions = ["Other dogs", "Kids", "Cats"]
    let specialNeedsOptions = ["Yes", "No", "Maybe"]
    
    var canContinue: Bool {
        selectedActivity != nil &&
        selectedHome != nil &&
        selectedWorkSchedule != nil &&
        selectedOtherPets != nil &&
        selectedDogSize != nil &&
        selectedGender != nil &&
        !selectedGoodWith.isEmpty &&
        !selectedTemperament.isEmpty &&
        selectedSpecialNeeds != nil
    }
    
    private var authorizationStatusText: String {
        switch locationManager.authorizationStatus {
        case .notDetermined: return "Not Determined"
        case .restricted: return "Restricted"
        case .denied: return "Denied"
        case .authorizedAlways: return "Authorized Always"
        case .authorizedWhenInUse: return "Authorized When In Use"
        @unknown default: return "Unknown"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Let your future dog get to know you…")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    
                    // Age Slider als Section mit Button-Style
                    ageSliderSection()
                    
                    sectionEnum(title: "Activity Level", options: EnergyLevel.allCases, selection: $selectedActivity)
                    
                    section(title: "Home Environment", options: homeEnvironments, selection: $selectedHome)
                    
                    section(title: "Work Schedule", options: workSchedules, selection: $selectedWorkSchedule)
                    
                    section(title: "Other Pets", options: otherPetOptions, selection: $selectedOtherPets)
                    
                    Text("What you're looking for...")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    sectionEnum(title: "Dog Size", options: Size.allCases, selection: $selectedDogSize)
                    
                    sectionEnum(title: "Gender", options: Gender.allCases, selection: $selectedGender)
                    
                    // EnergyLevel schon als Auswahl oben
                    
                    multiSelectSection(title: "Good with", options: goodWithOptions, selection: $selectedGoodWith)
                    
                    multiSelectSectionEnum(title: "Temperament Preferences", options: PersonalityTrait.allCases, selection: $selectedTemperament)
                    
                    section(title: "Open to Special Needs / Older Dogs", options: specialNeedsOptions, selection: $selectedSpecialNeeds)
                    
                    Button(action: {
                        navigateToHome = true
                    }) {
                        Text("Adopt your Dog")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(canContinue ? .black : .gray)
                            .frame(width: 316, height: 44)
                            .background(canContinue ? Color(hex: "F8CE9C") : Color.gray.opacity(0.3))
                            .cornerRadius(15)
                    }
                    .disabled(!canContinue)
                    .opacity(canContinue ? 1 : 0.6)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 30)
                    
                    NavigationLink(
                        destination: HomePageStartTournament(),
                        isActive: $navigateToHome
                    ) {
                        EmptyView()
                    }
                }
                .padding()
                .background(Color.white)
            }
        }
    }
    
    // MARK: - Age Slider Section
    
    func ageSliderSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider().background(Color.black)
            Text("Age")
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            HStack {
                Text("\(Int(selectedAge)) years")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 60, alignment: .leading)
                
                Slider(value: $selectedAge, in: ageRange, step: 1)
                    .accentColor(Color(hex: "F8CE9C"))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
            )
            .cornerRadius(15)
        }
    }
    
    // MARK: - Section for Enums
    
    func sectionEnum<T: RawRepresentable & CaseIterable & Equatable & Hashable>(
        title: String,
        options: [T],
        selection: Binding<T?>
    ) -> some View where T.RawValue == String {
        VStack(alignment: .leading, spacing: 10) {
            Divider().background(Color.black)
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)

            FlowLayout(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        if selection.wrappedValue == option {
                            selection.wrappedValue = nil
                        } else {
                            selection.wrappedValue = option
                        }
                    }) {
                        Text(option.rawValue.capitalized)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(selection.wrappedValue == option ? Color(hex: "F8CE9C") : Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
                            .cornerRadius(15)
                    }
                }
            }
        }
    }

    
    // MARK: - Section for Strings
    
    func section(title: String, options: [String], selection: Binding<String?>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider().background(Color.black)
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            FlowLayout(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        if selection.wrappedValue == option {
                            selection.wrappedValue = nil
                        } else {
                            selection.wrappedValue = option
                        }
                    }) {
                        Text(option)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(selection.wrappedValue == option ? Color(hex: "F8CE9C") : Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
                            .cornerRadius(15)
                    }
                }
            }
        }
    }
    
    // MARK: - MultiSelect for Strings
    
    func multiSelectSection(
        title: String,
        options: [String],
        selection: Binding<Set<String>>
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider().background(Color.black)
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)

            FlowLayout(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        if selection.wrappedValue.contains(option) {
                            selection.wrappedValue.remove(option)
                        } else {
                            selection.wrappedValue.insert(option)
                        }
                    }) {
                        Text(option)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(selection.wrappedValue.contains(option) ? Color(hex: "F8CE9C") : Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
                            .cornerRadius(15)
                    }
                }
            }
        }
    }

    
    // MARK: - MultiSelect for Enums
    
    func multiSelectSectionEnum<T: RawRepresentable & CaseIterable & Hashable & Identifiable>(title: String, options: [T], selection: Binding<Set<T>>) -> some View where T.RawValue == String, T.ID == T {
        VStack(alignment: .leading, spacing: 10) {
            Divider().background(Color.black)
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            FlowLayout(spacing: 10) {
                ForEach(options) { option in
                    Button(action: {
                        if selection.wrappedValue.contains(option) {
                            selection.wrappedValue.remove(option)
                        } else {
                            selection.wrappedValue.insert(option)
                        }
                    }) {
                        Text(option.rawValue.capitalized)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(selection.wrappedValue.contains(option) ? Color(hex: "F8CE9C") : Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
                            .cornerRadius(15)
                    }
                }
            }
        }
    }
}


// MARK: - FlowLayout for flexible button layout

struct FlowLayout<Content: View>: View {
    let spacing: CGFloat
    let content: () -> Content

    init(spacing: CGFloat = 8, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(minHeight: 10)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            content()
                .fixedSize()
                .alignmentGuide(.leading) { d in
                    if (abs(width - d.width) > g.size.width) {
                        width = 0
                        height -= d.height + spacing
                    }
                    let result = width
                    if d.width != 0 {
                        width -= d.width + spacing
                    }
                    return result
                }
                .alignmentGuide(.top) { _ in
                    let result = height
                    if height != 0 {
                        // height will be updated by leading
                    }
                    return result
                }
        }
    }
}

#Preview {
    CharacterSelectionView()
}

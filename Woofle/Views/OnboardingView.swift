//
//  OnboardingView.swift
//  Woofle
//
//  Created by Rahel on 28/05/25.
//

import SwiftUI
import MapKit
import CoreLocation

// MARK: - Onboarding Data Manager
class OnboardingViewModel: ObservableObject {
    @StateObject private var dynamicOptions = DynamicOptions()
    @Published var currentStep = 0
    
    // Personal info (required)
    @Published var name: String = ""
    @Published var gender: HumanGender = .male
    @Published var birthYear: String = ""
    @Published var selectedLocation: CLLocationCoordinate2D?
    
    // Dog preferences (optional)
    @Published var preferredGender: Gender?
    @Published var selectedEnergyLevels: Set<EnergyLevel> = []
    @Published var selectedBreeds: Set<String> = []
    @Published var selectedSizes: Set<Size> = []
    @Published var selectedPersonalities: Set<PersonalityTrait> = []
    @Published var preferredRadius: Double = 10.0
    @Published var goodWithKids: Bool? = nil
    @Published var goodWithOtherDogs: Bool? = nil
    
    var availableBreeds: [String] {
        dynamicOptions.breeds
    }
    
    var canProceedToNext: Bool {
        switch currentStep {
        case 0, 1: return !name.isEmpty
        case 2: return !birthYear.isEmpty && Int(birthYear) != nil
        case 3: return true // Gender has default
        case 4: return true
        default: return true // Optional steps
        }
    }
    
    func nextStep() {
        currentStep += 1
    }
    
    func previousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }
    
    func skipStep() {
        currentStep += 1
    }
    
    func completeOnboarding() -> UserProfile {
        let location = GeoLocation(
            latitude: selectedLocation?.latitude ?? 0.0,
            longitude: selectedLocation?.longitude ?? 0.0
        )
        
        let preferences = UserPreferences(
            preferredBreeds: selectedBreeds.isEmpty ? nil : Array(selectedBreeds),
            sizePreferences: Array(selectedSizes),
            activityLevels: Array(selectedEnergyLevels),
            goodWithKids: goodWithKids,
            goodWithOtherDogs: goodWithOtherDogs,
            personalityPreferences: Array(selectedPersonalities),
            preferredRadius: preferredRadius
        )
        
        let userProfile = UserProfile(
            id: UUID(),
            name: name,
            gender: gender,
            age: Int(birthYear) != nil ? Calendar.current.component(.year, from: Date()) - Int(birthYear)! : 25,
            location: location,
            preferences: preferences
        )
        
        return userProfile
    }
}

// MARK: - Main Onboarding View
struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.currentStep {
                case 0:
                    WelcomeView()
//                case 1:
//                    NameInputView()
                case 2:
                    BirthYearView()
                case 3:
                    GenderSelectionView()
//                case 4:
//                    LocationSelectionView()
                case 5:
                    PreferredGenderView()
                case 6:
                    EnergyLevelView()
                case 7:
                    BreedPreferenceView()
                case 8:
                    SizePreferenceView()
                case 9:
                    PersonalityPreferenceView()
                case 10:
                    DistancePreferenceView()
                default:
                    CompletionView()
                }
            }
            .environmentObject(viewModel)
        }
        .fullScreenCover(isPresented: $navigateToHome) {
            HomePageStartTournament()
        }
        .onReceive(NotificationCenter.default.publisher(for: .onboardingCompleted)) { _ in
            navigateToHome = true
        }
    }
}

// MARK: - Welcome View
struct WelcomeView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
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
                // Circle size
                
                Image("Woofle_01")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 290, height: 290) // Image size
                    .clipShape(Circle())
            }
            Text("Welcome to Woofle!")
                            .font(.title2)
                            .fontWeight(.semibold)
            
            ZStack(alignment: .trailing) {
                    TextField("Your Name", text: $viewModel.name)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        .submitLabel(.done)
                        .onSubmit {
                            if viewModel.canProceedToNext {
                                viewModel.nextStep()
                            }
                        }

                    if !viewModel.name.isEmpty {
                        Button(action: {
                            if viewModel.canProceedToNext {
                                viewModel.nextStep()
                            }
                        }) {
                            Image(systemName: "arrow.turn.down.left")
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                        .padding(.trailing, 8)
                    }
                
                }
                .frame(width: 314, height: 44)
                .padding(.horizontal, 40)
                .padding(.top, 10)

                Spacer()

        }
        .padding()
    }
}

// MARK: - Name Input View
//struct NameInputView: View {
//    @EnvironmentObject var viewModel: OnboardingViewModel
//    
//    var body: some View {
//        OnboardingTemplate(
//            title: "What's your name?",
//            canSkip: false
//        ) {
//            VStack(spacing: 20) {
//                TextField("Your Name", text: $viewModel.name)
//                    .textFieldStyle(CustomTextFieldStyle())
//            }
//        }
//    }
//}

// MARK: - Birth Year View
struct BirthYearView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "What's your birth year?",
            canSkip: false
        ) {
            VStack(spacing: 20) {
                TextField("2001", text: $viewModel.birthYear)
                    .textFieldStyle(CustomTextFieldStyle())
                    .keyboardType(.numberPad)
            }
        }
    }
}

// MARK: - Gender Selection View
struct GenderSelectionView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "What is your gender?",
            canSkip: false
        ) {
            VStack(spacing: 15) {
                ForEach(HumanGender.allCases, id: \.self) { gender in
                    SelectionButton(
                        title: gender.rawValue.capitalized,
                        isSelected: viewModel.gender == gender
                    ) {
                        viewModel.gender = gender
                    }
                }
            }
        }
    }
}

//// MARK: - Location Selection View
//struct LocationSelectionView: View {
//    @EnvironmentObject var viewModel: OnboardingViewModel
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
//    
//    var body: some View {
//        OnboardingTemplate(
//            title: "Where do you live?",
//            subtitle: "Distance between you and the dog shelter:",
//            canSkip: false
//        ) {
//            VStack {
//                Map(coordinateRegion: $region, annotationItems: []) { _ in
//                    EmptyView()
//                }
//                .frame(height: 300)
//                .cornerRadius(12)
//                .onTapGesture { location in
//                    let coordinate = region.center
//                    viewModel.selectedLocation = coordinate
//                }
//                
//                if viewModel.selectedLocation != nil {
//                    HStack {
//                        Image(systemName: "location.fill")
//                            .foregroundColor(.green)
//                        Text("Location selected")
//                            .foregroundColor(.green)
//                    }
//                    .padding(.top, 10)
//                }
//            }
//        }
//    }
//}

// MARK: - Preferred Gender View
struct PreferredGenderView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "Preferred gender?",
            canSkip: true
        ) {
            VStack(spacing: 15) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    SelectionButton(
                        title: gender.rawValue.capitalized,
                        isSelected: viewModel.preferredGender == gender
                    ) {
                        viewModel.preferredGender = gender
                    }
                }
            }
        }
    }
}

// MARK: - Energy Level View
struct EnergyLevelView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "Choose matching energy levels:",
            canSkip: true
        ) {
            VStack(spacing: 15) {
                ForEach(EnergyLevel.allCases, id: \.self) { level in
                    SelectionButton(
                        title: level.rawValue.capitalized,
                        isSelected: viewModel.selectedEnergyLevels.contains(level)
                    ) {
                        if viewModel.selectedEnergyLevels.contains(level) {
                            viewModel.selectedEnergyLevels.remove(level)
                        } else {
                            viewModel.selectedEnergyLevels.insert(level)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Breed Preference View
struct BreedPreferenceView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "Choose breeds you like:",
            canSkip: true
        ) {
            VStack(spacing: 15) {
                ForEach(viewModel.availableBreeds, id: \.self) { breed in
                    SelectionButton(
                        title: breed,
                        isSelected: viewModel.selectedBreeds.contains(breed)
                    ) {
                        if viewModel.selectedBreeds.contains(breed) {
                            viewModel.selectedBreeds.remove(breed)
                        } else {
                            viewModel.selectedBreeds.insert(breed)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Size Preference View
struct SizePreferenceView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "Choose preferred sizes:",
            canSkip: true
        ) {
            VStack(spacing: 15) {
                ForEach(Size.allCases, id: \.self) { size in
                    SelectionButton(
                        title: size.rawValue.capitalized,
                        isSelected: viewModel.selectedSizes.contains(size)
                    ) {
                        if viewModel.selectedSizes.contains(size) {
                            viewModel.selectedSizes.remove(size)
                        } else {
                            viewModel.selectedSizes.insert(size)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Personality Preference View
struct PersonalityPreferenceView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "The dog should be:",
            canSkip: true
        ) {
            VStack(spacing: 15) {
                ForEach(PersonalityTrait.allCases, id: \.self) { trait in
                    SelectionButton(
                        title: trait.rawValue.capitalized,
                        isSelected: viewModel.selectedPersonalities.contains(trait)
                    ) {
                        if viewModel.selectedPersonalities.contains(trait) {
                            viewModel.selectedPersonalities.remove(trait)
                        } else {
                            viewModel.selectedPersonalities.insert(trait)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Distance Preference View
struct DistancePreferenceView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingTemplate(
            title: "Distance between you and the dog shelter:",
            canSkip: true
        ) {
            VStack(spacing: 20) {
                HStack {
                    Text("0 km")
                    Slider(value: $viewModel.preferredRadius, in: 0...50, step: 1)
                    Text("50 km")
                }
                
                Text("\(Int(viewModel.preferredRadius)) km")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
    }
}

// MARK: - Completion View
struct CompletionView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Setup Complete!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Let's find your perfect furry friend!")
                .font(.title3)
                .multilineTextAlignment(.center)
            
            Button("Start Matching") {
                let userProfile = viewModel.completeOnboarding()
                // Save the user profile using your UserViewModel if needed
                NotificationCenter.default.post(name: .onboardingCompleted, object: userProfile)
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

// MARK: - Reusable Components
struct OnboardingTemplate<Content: View>: View {
    let title: String
    let subtitle: String?
    let canSkip: Bool
    let content: Content
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    init(title: String, subtitle: String? = nil, canSkip: Bool, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.canSkip = canSkip
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 8) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            
            // Content
            content
            
            Spacer()
            
            // Navigation Buttons
            VStack(spacing: 15) {
                Button("Continue") {
                    viewModel.nextStep()
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!viewModel.canProceedToNext)
                
                if canSkip {
                    Button("Skip") {
                        viewModel.skipStep()
                    }
                    .foregroundColor(.secondary)
                }
            }
        }
        .padding()
    }
}

struct SelectionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(isSelected ? Color.green : Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

// MARK: - Custom Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
    }
}

// MARK: - Notification Extension
extension Notification.Name {
    static let onboardingCompleted = Notification.Name("onboardingCompleted")
}

#Preview {
    OnboardingView()
}


import SwiftUI
import MapKit
import CoreLocation

import SwiftUI
import MapKit
import CoreLocation

// MARK: - User Profile Settings Main View
struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack(spacing: 0) {
            header
            
            ScrollView {
                VStack(spacing: 0) {
                    avatarSection
                    personalInformationSection
                    dogPreferencesSection
                    Spacer(minLength: 100)
                }
            }
        }
        .background(Color.gray.opacity(0.05))
        .navigationBarHidden(true)
    }
    
    private var header: some View {
        ZStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "B67A4B"))
                        .font(.system(size: 20, weight: .medium))
                }
                Spacer()
            }
            
            Text("Profile Settings")
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    private var avatarSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(hex: "A3B18A"))
                    .frame(width: 60, height: 60)
                
                Circle()
                    .fill(Color(hex: "A3B18A"))
                    .frame(width: 140, height: 140)

                Image("Woofle_01")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())

                
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
//                            Circle()
//                                .fill(Color.gray.opacity(0.8))
//                                .frame(width: 35, height: 35)
//                            
//                            Image(systemName: "camera.fill")
//                                .font(.system(size: 16))
//                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .frame(width: 120, height: 120)
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 40)
    }
    
    private var personalInformationSection: some View {
        VStack(spacing: 0) {
            Text("Personal Information")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 16)
            
            NavigationLink(destination: PersonalSettingsDetailView()
                            .environmentObject(userViewModel)) {
                rowView(
                    iconName: "person.fill",
                    title: userViewModel.user.name.isEmpty ? "Set Name" : userViewModel.user.name,
                    subtitle: "Change your personal settings"
                )
            }
            
            Divider()
                .padding(.leading, 72)
            
            NavigationLink(destination: LocationSettingsDetailView()
                            .environmentObject(userViewModel)) {
                rowView(
                    iconName: "location.fill",
                    title: "Home Address",
                    subtitle: "Update location and shelter radius"
                )
            }
        }
        .background(Color.white)
    }
    
    private var dogPreferencesSection: some View {
        VStack(spacing: 0) {
            Text("Dog Preferences")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 32)
                .padding(.bottom, 16)
            
            NavigationLink(destination: Text("Dog Basics Settings")) {
                rowView(
                    iconName: "pawprint.fill",
                    title: "Dog Basics",
                    subtitle: "Choose size, energy level, and breeds"
                )
            }
            
            Divider()
                .padding(.leading, 72)
            
            NavigationLink(destination: Text("Behaviour Settings")) {
                rowView(
                    iconName: "hand.raised.fill",
                    title: "Behaviour",
                    subtitle: "Edit dog compatibility and personality"
                )
            }
        }
        .background(Color.white)
    }
    
    private func rowView(iconName: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 40, height: 40)
                
                Image(systemName: iconName)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "B67A4B"))
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
        .background(Color.white)
    }
}


// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(UserViewModel())
        }
    }
}

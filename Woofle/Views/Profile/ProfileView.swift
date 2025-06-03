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

            VStack(spacing: 16) {
                avatarSection
                personalInformationSection
                dogPreferencesSection
                
                Button("Reset All Data") {
                    userViewModel.resetAllUserData()
                }

            }
            .padding(.bottom)
            .background(.secondary.opacity(0.05))
            
            Spacer()
        }
        .navigationBarHidden(true)
    }

    private var header: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "B67A4B"))
                        .font(.system(size: 20, weight: .medium))
                }
                Spacer()
                Text("Profile Settings")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
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
                    .frame(width: 120, height: 120)

                Image("Woofle_01")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
            }
        }
        .padding(.top, 16)
    }

    private var personalInformationSection: some View {
        VStack(spacing: 0) {
            sectionTitle("Personal Information")

            NavigationLink(destination: PersonalSettingsDetailView()) {
                rowView(
                    iconName: "person.fill",
                    title: userViewModel.user.name.isEmpty ? "Set Name" : userViewModel.user.name,
                    subtitle: "Change your personal settings"
                )
            }

            Divider().padding(.leading, 72)

            NavigationLink(destination: LocationSettingsDetailView()) {
                rowView(
                    iconName: "location.fill",
                    title: "Home Address",
                    subtitle: "Update location and radius"
                )
            }
        }
        .background(Color(.systemBackground))
    }

    private var dogPreferencesSection: some View {
        VStack(spacing: 0) {
            sectionTitle("Dog Preferences")

            NavigationLink(destination: DogBasicsView()) {
                rowView(
                    iconName: "pawprint.fill",
                    title: "Dog Basics",
                    subtitle: "Update dog traits"
                )
            }
            Divider().padding(.leading, 72)

            NavigationLink(destination: DogBehaviourView()
                .environmentObject(userViewModel)) {
                rowView(
                    iconName: "hand.raised.fill",
                    title: "Behaviour",
                    subtitle: "Edit dog personality"
                )
            }

        }
        .background(Color(.systemBackground))
    }

    private func rowView(iconName: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(hex: "A3B18A"))
                    .frame(width: 40, height: 40)

                Image(systemName: iconName)
                    .font(.system(size: 18))
                    .foregroundColor(Color(.systemBackground))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

        }
        .padding(.horizontal)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.medium)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 12)
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

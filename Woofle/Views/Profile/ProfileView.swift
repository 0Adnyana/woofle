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
            }
            .padding(.bottom)
            .background(Color.gray.opacity(0.05))
        }
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
                    .frame(width: 120, height: 120)

                Image("Woofle_01")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
            }
        }
        .padding(.top, 16)
    }

    private var personalInformationSection: some View {
        VStack(spacing: 0) {
            sectionTitle("Personal Information")

            NavigationLink(destination: PersonalSettingsDetailView()
                .environmentObject(userViewModel)) {
                rowView(
                    iconName: "person.fill",
                    title: userViewModel.user.name.isEmpty ? "Set Name" : userViewModel.user.name,
                    subtitle: "Change your personal settings"
                )
            }

            Divider().padding(.leading, 72)

            NavigationLink(destination: LocationSettingsDetailView()
                .environmentObject(userViewModel)) {
                rowView(
                    iconName: "location.fill",
                    title: "Home Address",
                    subtitle: "Update location and radius"
                )
            }
        }
        .background(Color.white)
    }

    private var dogPreferencesSection: some View {
        VStack(spacing: 0) {
            sectionTitle("Dog Preferences")

            NavigationLink(destination: DogBasicsView()
                .environmentObject(userViewModel)) {
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

//            Image(systemName: "chevron.right")
//                .font(.system(size: 14, weight: .medium))
//                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
        .background(Color.white)
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.medium)
            .foregroundColor(.gray)
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

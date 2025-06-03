//
//  TournamentMatchingService.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 28/05/25.
//

import Foundation
import CoreLocation

struct TournamentMatchingService {
    func match(user: UserProfile, dogs: [Dog], shelters: [Shelter]) -> [Dog] {
        func distance(from: GeoLocation, to: GeoLocation) -> Double {
            let a = CLLocation(latitude: from.latitude, longitude: from.longitude)
            let b = CLLocation(latitude: to.latitude, longitude: to.longitude)
            return a.distance(from: b) / 1000
        }

        let filtered = dogs.filter { dog in
            guard let shelter = shelters.first(where: { $0.id == dog.shelterId }) else {
                print("❌ No shelter found for dog \(dog.name)")
                return false
            }
            let dist = distance(from: user.location, to: shelter.location)
            guard dist <= user.preferences.preferredRadius else {
                print("❌ Dog \(dog.name) too far: \(dist)km > \(user.preferences.preferredRadius)km")
                return false
            }
            if let requiresKids = user.preferences.goodWithKids,
               requiresKids == true && dog.traits.goodWithKids == false {
                print("❌ Dog \(dog.name) rejected due to goodWithKids mismatch")
                return false
            }

            if let requiresOtherDogs = user.preferences.goodWithOtherDogs,
               requiresOtherDogs == true && dog.traits.goodWithOtherDogs == false {
                print("❌ Dog \(dog.name) rejected due to goodWithOtherDogs mismatch")
                return false
            }
            return true
        }

        if filtered.isEmpty {
            print("⚠️ TournamentMatchingService: No dogs passed the filter.")
            return []
        }

        let scored = filtered.map { dog -> (Dog, Int) in
            var score = 0
            if let preferredBreeds = user.preferences.preferredBreeds,
               preferredBreeds.contains(dog.breed) { score += 3 }
            if user.preferences.sizePreferences.contains(dog.traits.size) { score += 2 }
            if user.preferences.genderPreferences.contains(dog.gender) { score += 2 }
            if user.preferences.activityLevels.contains(dog.traits.energyLevel) { score += 2 }
            score += dog.traits.personalityTags.filter { user.preferences.personalityPreferences.contains($0) }.count
            if let goodWithOther = user.preferences.goodWithOtherDogs,
               goodWithOther == dog.traits.goodWithOtherDogs { score += 1 }
            if dog.traits.isTrained { score += 1 }
            return (dog, score)
        }

        print("✅ TournamentMatchingService: \(filtered.count) dogs filtered, \(scored.count) scored.")

        return scored.sorted {
            $0.1 == $1.1 ? $0.0.createdAt < $1.0.createdAt : $0.1 > $1.1
        }
        .prefix(16)
        .map { $0.0 }
    }

}

//// DEPRECATED
//
//import Foundation
//import CoreLocation
//
//struct TournamentSelector {
//    struct Result {
//        let dogs: [Dog]
//    }
//
//    static func run(user: UserProfile, dogs: [Dog], shelters: [Shelter]) -> Result {
//        func distance(from: GeoLocation, to: GeoLocation) -> Double {
//            let a = CLLocation(latitude: from.latitude, longitude: from.longitude)
//            let b = CLLocation(latitude: to.latitude, longitude: to.longitude)
//            return a.distance(from: b) / 1000 // in km
//        }
//
//        // Step 1: Filter
//        let filtered = dogs.filter { dog in
//            guard let shelter = shelters.first(where: { $0.id == dog.shelterId }) else { return false }
//            let dist = distance(from: user.location, to: shelter.location)
//            guard dist <= user.preferences.preferredRadius else { return false }
//
//            if let requiresKids = user.preferences.goodWithKids, requiresKids != dog.traits.goodWithKids {
//                return false
//            }
//
//            return true
//        }
//
//        // Step 2: Score
//        let scored = filtered.map { dog -> (dog: Dog, score: Int) in
//            var score = 0
//
//            if let preferredBreeds = user.preferences.preferredBreeds,
//               preferredBreeds.contains(dog.breed) {
//                score += 3
//            }
//
//            if user.preferences.sizePreferences.contains(dog.traits.size) {
//                score += 2
//            }
//
//            if user.preferences.activityLevels.contains(dog.traits.energyLevel) {
//                score += 2
//            }
//
//            score += dog.traits.personalityTags.filter {
//                user.preferences.personalityPreferences.contains($0)
//            }.count
//
//            if let goodWithOther = user.preferences.goodWithOtherDogs,
//               goodWithOther == dog.traits.goodWithOtherDogs {
//                score += 1
//            }
//
//            if dog.traits.isTrained {
//                score += 1
//            }
//
//            return (dog, score)
//        }
//
//        // Step 3: Sort and return top 16 by score (tie-breaker: createdAt)
//        let topDogs = scored.sorted {
//            if $0.score == $1.score {
//                return $0.dog.createdAt < $1.dog.createdAt
//            } else {
//                return $0.score > $1.score
//            }
//        }
//        .prefix(16)
//        .map { $0.dog }
//
//        return Result(dogs: topDogs)
//    }
//}

////
////  DogViewModel.swift
////  WoofleTesting
////
////  Created by I Made Bayu Putra Adnyana on 20/05/25.
////
//
//import Foundation
//
//final class DogViewModel: Identifiable, ObservableObject {
//    let id: UUID
//    let dog: Dog
//
//    init(_ dog: Dog) {
//        self.id = dog.id
//        self.dog = dog
//    }
//
//    var displayName: String { dog.name }
//    var gender: Gender { dog.gender }
//    var breed: String { dog.breed }
//    var imageURL: String { dog.pictureURL }
//    var shelterId: UUID { dog.shelterId }
//    var ageText: String {
//        let years = dog.ageInMonths / 12
//        let months = dog.ageInMonths % 12
//        return years > 0 ? "\(years) Years \(months) Month" : "\(months) Month"
//    }
//    var personalityTags: [PersonalityTrait] { dog.traits.personalityTags }
//    var isVaccinated: Bool { dog.traits.isVaccinated }
//    var isNeutered: Bool { dog.traits.isNeutered }
//    var isTrained: Bool { dog.traits.isTrained }
//    var goodWithKids: Bool { dog.traits.goodWithKids }
//    var goodWithOtherDogs: Bool { dog.traits.goodWithOtherDogs }
//    var energyLevel: EnergyLevel { dog.traits.energyLevel }
//    var size: Size { dog.traits.size }
//}

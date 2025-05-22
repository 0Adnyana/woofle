//
//  ShelterViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

final class ShelterViewModel: ObservableObject {
    let shelter: Shelter
    var id: UUID { shelter.id }

    init(_ shelter: Shelter) {
        self.shelter = shelter
    }
}

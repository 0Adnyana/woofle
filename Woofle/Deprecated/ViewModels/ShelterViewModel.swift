//
//  ShelterViewModel.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 20/05/25.
//

import Foundation

final class ShelterViewModel: ObservableObject {
    let shelter: Shelter
    let id: UUID

    init(_ shelter: Shelter) {
        self.id = shelter.id
        self.shelter = shelter
    }
}

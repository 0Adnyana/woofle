//
//  Untitled.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 22/05/25.
//

import Foundation

struct DogWithShelter: Identifiable {
    let id: UUID = UUID()
    
    let dog: Dog
    let shelter: Shelter
}

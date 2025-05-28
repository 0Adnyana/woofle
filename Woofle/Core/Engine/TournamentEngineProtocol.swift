//
//  TournamentEngineProtocol.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 28/05/25.
//

import Foundation

protocol TournamentEngineProtocol {
    func generateSeedingBracket(from dogs: [Dog]) -> [[Dog]]
    func generateNextBracket(from dogs: [Dog]) -> [[Dog]]
}

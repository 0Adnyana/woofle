//
//  TournamentEngine.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 25/05/25.
//

import Foundation

struct TournamentEngine: TournamentEngineProtocol {
    func generateSeedingBracket(from dogs: [Dog]) -> [[Dog]] {
        let count = dogs.count
        return (0..<count / 2).map { i in
            [dogs[i], dogs[count - 1 - i]]
        }
    }

    func generateNextBracket(from dogs: [Dog]) -> [[Dog]] {
        let count = dogs.count
        return (0..<count / 2).map { i in
            [dogs[i * 2], dogs[i * 2 + 1]]
        }
    }
}

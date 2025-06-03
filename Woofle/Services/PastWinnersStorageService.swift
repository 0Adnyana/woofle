//
//  PastWinnersStorageService.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 28/05/25.
//

import Foundation

final class PastWinnersStorageService {
    private let fileName = "past_winners.json"

    func load() -> [UUID] {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName),
              let data = try? Data(contentsOf: url),
              let ids = try? JSONDecoder().decode([UUID].self, from: data) else {
            return []
        }
        return ids
    }

    func save(newWinners: [Dog]) {
        var all = load()
        all.append(contentsOf: newWinners.map { $0.id })
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
            print("❌ Could not get file URL")
            return
        }
        do {
            let data = try JSONEncoder().encode(all)
            try data.write(to: url)
            print("✅ Saved winners to \(url)")
        } catch {
            print("❌ Failed to save winners: \(error)")
        }
    }
    
    func delete(deletedDog: Dog) {
        var all = load()
        all.removeAll(where: { $0 == deletedDog.id })
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
            print("❌ Could not get file URL")
            return
        }
        do {
            let data = try JSONEncoder().encode(all)
            try data.write(to: url)
            print("✅ Saved winners to \(url)")
        } catch {
            print("❌ Failed to save winners: \(error)")
        }
    }
    
    func deleteAll() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName),
              FileManager.default.fileExists(atPath: url.path) else {
            print("⚠️ No past_winners.json file to delete.")
            return
        }

        do {
            try FileManager.default.removeItem(at: url)
            print("🗑️ Deleted all past winners from \(url)")
        } catch {
            print("❌ Failed to delete past winners file: \(error)")
        }
    }

    
    
}

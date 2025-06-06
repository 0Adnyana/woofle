//
//  UserStorageService.swift
//  Woofle
//
//  Created by I Made Bayu Putra Adnyana on 28/05/25.
//

import Foundation

final class UserStorageService {
    private let fileName = "user.json"
    
    func load() -> UserProfile? {
        guard let url = getFileURL(),
              let data = try? Data(contentsOf: url),
              let user = try? JSONDecoder.iso8601WithFractionalSeconds.decode(UserProfile.self, from: data) else {
            return nil
        }
        return user
    }

    func save(_ user: UserProfile) {
        guard let url = getFileURL() else {
            print("❌ Could not get file URL")
            return
        }
        do {
            let data = try JSONEncoder.iso8601WithFractionalSeconds.encode(user)
            try data.write(to: url)
            print("✅ Saved user profile to \(url)")
        } catch {
            print("❌ Failed to save user profile: \(error)")
        }
    }
    
    func delete() {
        guard let url = getFileURL() else { return }
        try? FileManager.default.removeItem(at: url)
    }

    private func getFileURL() -> URL? {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(fileName)
    }
}

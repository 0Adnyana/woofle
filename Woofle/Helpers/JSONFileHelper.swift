//
//  JSONHelper.swift
//  WoofleTesting
//
//  Created by I Made Bayu Putra Adnyana on 21/05/25.
//

import Foundation

struct JSONFileHelper {
    static func load<T: Decodable>(fileName: String, fallback: T) -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("⚠️ File not found: \(fileName)")
            return fallback
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder.iso8601WithFractionalSeconds.decode(T.self, from: data)
        } catch {
            print("❌ Failed to decode \(fileName): \(error)")
            return fallback
        }
    }

    static func save<T: Encodable>(_ data: T, to fileName: String) {
        do {
            let encoded = try JSONEncoder.iso8601WithFractionalSeconds.encode(data)
            if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = docDir.appendingPathComponent(fileName)
                try encoded.write(to: fileURL)
                print("✅ Saved to \(fileURL)")
            }
        } catch {
            print("❌ Failed to save \(fileName): \(error)")
        }
    }
}

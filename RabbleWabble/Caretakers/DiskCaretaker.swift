//
//  DiskCaretaker.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/11/26.
//

import Foundation

public final class DiskCaretaker {

    // MARK: - Properties

    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()

    // MARK: - Static Methods

    public static func createDocumentURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            .first!

        return url.appendingPathComponent(fileName)
            .appendingPathExtension("json")
    }

    public static func save<T: Codable>(
        _ object: T,
        to fileName: String
    ) throws {
        do {
            let url = createDocumentURL(withFileName: fileName)
            let data = try encoder.encode(object)

            try data.write(to: url, options: .atomic)
        } catch {
            print("Failed to save `\(object)` with error: \(error.localizedDescription)")

            throw error
        }
    }

    public static func retrieve<T: Codable>(
        _ type: T.Type,
        from url: URL
    ) throws -> T {
        do {
            let data = try Data(contentsOf: url)

            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to retrieve from `\(url)` with error: \(error.localizedDescription)")

            throw error
        }
    }

    public static func retrieve<T: Codable>(
        _ type: T.Type,
        from fileName: String
    ) throws -> T {
        let url = createDocumentURL(withFileName: fileName)

        return try retrieve(T.self, from: url)
    }

}

//
//  CacheManager.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 24/05/2022.
//

import Foundation
import Files

enum DataType: String, CaseIterable {
    case movies
}

// https://developer.apple.com/documentation/watchconnectivity/wcsession/1615667-transferfile
class CacheManager : CacheRepository {
    
    public static var shared: CacheManager = .init()
    
    let tempFolder: Folder = Folder.temporary
    private init ( ) {
        DataType.allCases.forEach { type in
            _ = try? tempFolder.createSubfolderIfNeeded(withName: (type.rawValue))
        }
    }
    
    func save(folderType: DataType, identifier: String, content: Data) -> Bool {
        do {
            let folder = try tempFolder.createSubfolderIfNeeded(withName: folderType.rawValue)
            let file = try folder.createFile(named: "\(identifier).json")
            try file.write(content)
        } catch {
            return false
        }
        return true
    }
    
    
    /// Get `Specific` or `Latest Create File` by its date
    /// - Parameters:
    ///   - folderType: Conform to `DataType`
    ///   - identifier: `String` to return Specific file identifier or `nil` to return latest
    /// - Returns: Data
    func get(folderType: DataType, identifier: String?) -> Data? {
        do {
            if let identifier = identifier {
                let file = try tempFolder.file(at: "\(folderType.rawValue)/\(identifier).json")
                return try file.read()
            } else {
                return try tempFolder
                    .subfolder(at: folderType.rawValue)
                    .files.sorted(by: { $0.creationDate ?? Date() < $1.creationDate ?? Date() })
                    .first?
                    .read()
            }
        } catch {
            return nil
        }
    }
}

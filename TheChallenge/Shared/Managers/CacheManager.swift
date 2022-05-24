//
//  CacheManager.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 24/05/2022.
//

import Foundation
import Files


enum DataType : String, CaseIterable {
    case movies
}

// https://developer.apple.com/documentation/watchconnectivity/wcsession/1615667-transferfile
class CacheManager {
    public static var shared : CacheManager = .init()
    
    let tempFolder : Folder = Folder.temporary
    private init ( ) {
        DataType.allCases.forEach { type in
            _ = try? tempFolder.createSubfolderIfNeeded(withName:(type.rawValue))
        }
    }
    
    func save( folderType : DataType, identifier : String, content : Data ) -> Bool {
        do {
            let folder = try tempFolder.createSubfolderIfNeeded(withName: folderType.rawValue)
            let file = try folder.createFile(named: "\(identifier).json")
            try file.write(content)
        } catch {
            return false
        }
        return true
    }
    
    func get( folderType : DataType, identifier : String ) -> Data? {
        do {
            let file = try tempFolder.file(at: "\(folderType.rawValue)/\(identifier).json")
            return try file.read()
        } catch {
            return nil
        }
    }
}

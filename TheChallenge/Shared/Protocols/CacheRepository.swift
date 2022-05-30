//
//  CacheRepository.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 29/05/2022.
//

import Foundation

protocol CacheRepository {
    func save(folderType: DataType, identifier: String, content: Data) -> Bool
    func get(folderType: DataType, identifier: String?) -> Data?
}

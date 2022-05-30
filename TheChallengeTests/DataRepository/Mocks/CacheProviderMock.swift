//
//  CacheProviderMock.swift
//  TheChallengeTests
//
//  Created by Derouiche Elyes on 29/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import TheChallenge

class CacheProviderMock: CacheRepository {
    
    func save(folderType: DataType, identifier: String, content: Data) -> Bool {
        return true
    }
    
    func get(folderType: DataType, identifier: String?) -> Data? {
        return nil
    }
}

//
//  Repository.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 24/05/2022.
//

import Foundation
import Combine

protocol MovieRepository {
    associatedtype Entity

    func get(url: String, filePath: String) async throws -> Entity

}

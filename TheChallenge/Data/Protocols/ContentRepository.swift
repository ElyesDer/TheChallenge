//
//  ContentRepository.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 25/05/2022.
//

import Foundation

protocol ContentRepository {
    associatedtype Entity

    func get() async throws -> Entity

}

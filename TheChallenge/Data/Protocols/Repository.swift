//
//  Repository.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 24/05/2022.
//

import Foundation
import Combine

protocol Repository {
    associatedtype Entity

    func get() async throws -> ContentWrapper<[Content]>

}

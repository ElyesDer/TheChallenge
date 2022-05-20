//
//  View.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

struct ContentWrapper<T: Decodable>: Decodable {
    var strateMode: String
    var title: String
    var type: String
    var contents: T
}

//
//  Mockable.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

protocol Mockable {
    associatedtype T
    static var mocks : [T] { get }
}

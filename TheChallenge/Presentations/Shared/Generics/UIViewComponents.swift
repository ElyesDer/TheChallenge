//
//  UIViewComponents.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import UIKit

class UIModel {
    init() { }
}

protocol UIViewComponents: Hashable, AnyObject {
    var id: UUID { get }
    var model: UIModel { get }
    func render() -> UIView
}

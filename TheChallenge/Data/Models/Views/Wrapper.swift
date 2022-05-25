//
//  View.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import UIKit

struct ContentWrapper<T: Codable>: Codable {
    var strateMode: String
    var title: String
    var type: ContentRow
    var contents: T
}

protocol Configuration {
    var size: CGSize? { get }
}

struct TableViewCellConfiguration: Configuration {
    var size: CGSize?
}

struct RowRessource<T>: Identifiable {
    var id: String
    var `class`: AnyClass?
    var type: T
    var configuration: Configuration
}

enum ContentRow: String, CaseIterable, Codable {
    
    case contentRow
    case forYou
    
    func getRessource() -> RowRessource<Any> {
        switch self {
            case .contentRow:
                return .init(id: "MainCollectionTableViewCell", class: MainCollectionTableViewCell.self, type: MainCollectionTableViewCell.self,
                             configuration: TableViewCellConfiguration(size: nil))
            case .forYou:
                return .init(id: "MainCollectionTableViewCell", class: MainCollectionTableViewCell.self, type: MainCollectionTableViewCell.self,
                             configuration: TableViewCellConfiguration(size: .init(width: 160, height: 200)))
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let element = try? container.decode(String.self), let generic = ContentRow(rawValue: element) {
            self = generic
            return
        }
        throw DecodingError.typeMismatch(
            ContentRow.self,
            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ContentRow"))
    }
}

//
//  Rows.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

// MARK: - Content
struct Content: Identifiable, Codable {
    var id: UUID = { UUID() }()
    
    let isInOffer: Bool
    let subtitle, contentID: String
    let onClick: OnClick
    let title: String
    let urlImage, urlLogoChannel: String
    let type: String
    let parentalRatings: [ParentalRating]

    enum CodingKeys: String, CodingKey {
        case isInOffer, subtitle, contentID, onClick, title
        case urlImage = "URLImage"
        case urlLogoChannel = "URLLogoChannel"
        case type, parentalRatings
    }
}

extension Content: Hashable {
    
    static func == (lhs: Content, rhs: Content) -> Bool {
        lhs.contentID == rhs.contentID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(contentID)
    }
}

enum GenericDisplay: String, Codable {
    
    case detailPage
    case infoView
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let element = try? container.decode(String.self), let generic = GenericDisplay(rawValue: element) {
            self = generic
            return
        }
        throw DecodingError.typeMismatch(
            GenericDisplay.self,
            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GenericDisplay"))
    }
}

// MARK: - OnClick
struct OnClick: Codable {
    let urlPage: String
    let boName, path, displayName: String
    let displayTemplate: GenericDisplay

    enum CodingKeys: String, CodingKey {
        case urlPage = "URLPage"
        case boName = "BOName"
        case path, displayName, displayTemplate
    }
}

// MARK: - ParentalRating
struct ParentalRating: Codable {
    let value, authority: String
}

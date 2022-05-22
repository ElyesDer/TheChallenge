//
//  Movie.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

// MARK: - Welcome
struct Movie: Codable {
    let subtitle: String
    let sharingURL: String
    let formats: Formats
    let personnalities: [Personnality]
    let type, title: String
    let channelLogoURL: String
    let summary: String
    let imageURL: String
    let reviews: [Review]
    let productionYear: String
    let parentalRatings: [ParentalRating]
    let duration, contentID: String
    let trailerURL: String
    let editorialTitle: String
}

extension Movie : Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.contentID == rhs.contentID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(contentID)
    }
}

// MARK: - Formats
struct Formats: Codable {
    let video, audio: [String]
}

// MARK: - Personnality
struct Personnality: Codable {
    let personnalityPrefix: String
    let personnalitiesList: [String]

    enum CodingKeys: String, CodingKey {
        case personnalityPrefix = "prefix"
        case personnalitiesList
    }
}

// MARK: - Review
struct Review: Codable {
    let name: String
    let stars: Stars
    let review: String?
}

// MARK: - Stars
struct Stars: Codable {
    let type: String
    let value: Double
}


extension Movie : Mockable {
    
    typealias T = Movie
    
    static var mocks: [Movie] = [
        
        .init(subtitle: "subtitle", sharingURL: "sharingURL",
              formats: .init(video: [], audio: []), personnalities: [], type: "type", title: "title",
              channelLogoURL: "channelLogoURL", summary: "summary", imageURL: "imageURL", reviews: [],
              productionYear: "", parentalRatings: [], duration: "duration", contentID: "contentID_123", trailerURL: "trailerURL", editorialTitle: "editorialTitle"),
        
//            .init(subtitle: "subtitle", sharingURL: "sharingURL", formats: .init(video: [], audio: []), personnalities: [], type: "type", title: "title", channelLogoURL: "channelLogoURL", summary: "summary", imageURL: "imageURL", reviews: [], productionYear: "", parentalRatings: [], duration: "duration", contentID: "contentID_123", trailerURL: "trailerURL", editorialTitle: "editorialTitle"),
//        
//            .init(subtitle: "subtitle", sharingURL: "sharingURL", formats: .init(video: [], audio: []), personnalities: [], type: "type", title: "title", channelLogoURL: "channelLogoURL", summary: "summary", imageURL: "imageURL", reviews: [], productionYear: "", parentalRatings: [], duration: "duration", contentID: "contentID_123", trailerURL: "trailerURL", editorialTitle: "editorialTitle"),
//        
//            .init(subtitle: "subtitle", sharingURL: "sharingURL", formats: .init(video: [], audio: []), personnalities: [], type: "type", title: "title", channelLogoURL: "channelLogoURL", summary: "summary", imageURL: "imageURL", reviews: [], productionYear: "", parentalRatings: [], duration: "duration", contentID: "contentID_123", trailerURL: "trailerURL", editorialTitle: "editorialTitle"),
    ]
}

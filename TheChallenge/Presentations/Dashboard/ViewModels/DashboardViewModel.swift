//
//  DashboardViewModel.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

struct StructureCellModel {
    var row: ContentRow
    var content: [Content]
}

class DashboardViewModel {
    @Published var structuredRowProvider = [StructureCellModel]()
    
    func load() {
        structuredRowProvider = [
            .init(row: .forYou, content: [
                .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_123",
                      onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                     displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: [])
            ]),
            
            .init(row: .contentRow, content: [
                .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_123",
                      onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                     displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: [])
            ])
        ]
    }
}

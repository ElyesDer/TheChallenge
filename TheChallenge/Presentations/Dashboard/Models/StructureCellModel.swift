//
//  File.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

struct StructureCellModel: Mockable {
    typealias T = StructureCellModel
    
    var row: ContentRow
    var content: [Content]
    
    static var mocks: [T] = [
        .init(row: .forYou, content: [
            .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_11123",
                  onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                 displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: [])
        ]),
        
            .init(row: .contentRow, content: [
                .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_12342",
                      onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                     displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_12334",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contefrntID_12434",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contentasID_12342",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "concxcxtentID_12334",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "condstentID_12434",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contassentID_12342",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contentqwID_12334",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_12434",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contentID_12123342",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contentIDqwe_12334",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: []),
                
                    .init(isInOffer: true, subtitle: "subtitle", contentID: "contewentID_12434",
                          onClick: .init(urlPage: "urlPage", boName: "boName", path: "path", displayName: "displayName",
                                         displayTemplate: .detailPage), title: "title", urlImage: "urlImage", urlLogoChannel: "urlLogoChannel", type: "type", parentalRatings: [])
                
            ])
    ]
}

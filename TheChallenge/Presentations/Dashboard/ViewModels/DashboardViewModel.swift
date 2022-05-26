//
//  DashboardViewModel.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import Combine

class DashboardViewModel {
    
    @Published
    var structuredRowProvider = [StructureCellModel]()
    
    var serviceProvider: DataServiceProviderProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    var synchronisation: ContentSynchronisation
    
    init(serviceProvider: DataServiceProviderProtocol = Requester()) {
        self.serviceProvider = serviceProvider
        self.synchronisation = .init(serviceProvider: serviceProvider)
    }
    
    func load() {
        Task {
            do {
                let content = try await self.synchronisation
                    .get()
                DispatchQueue.main.async {
                    self.structuredRowProvider = [
                        StructureCellModel(row: content.type,
                                           content: content.contents.filter{ $0.isInOffer } )
                    ]
                }
            } catch {
                // error handling
            }
        }
    }
}

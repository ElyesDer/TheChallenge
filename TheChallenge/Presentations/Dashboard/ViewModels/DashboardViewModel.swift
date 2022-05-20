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
    
    init(serviceProvider: DataServiceProviderProtocol = Requester()) {
        self.serviceProvider = serviceProvider
    }
    
    func load() {
        serviceProvider
            .request(from: APIEndpoint(
                method: .get,
                endURL: .movies), of: ContentWrapper<[Content]>.self)
            .map { content in
                StructureCellModel(
                    row: content.type,
                    content: content.contents)
            }
            .sink { completion in
                switch completion {
                    case .finished : break
                    case .failure(let error) :
                        print(error)
                }
            } receiveValue: { structuredRow in
                // use this because ContentWrapper<[Content]> is not an array
                self.structuredRowProvider = [structuredRow]
            }
            .store(in: &cancellables)
    }
}

//
//  ContentSynchronisation.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 24/05/2022.
//

import Foundation
import Combine

class ContentSynchronisation: Repository {
    typealias Entity = ContentWrapper<[Content]>
    
    var serviceProvider: DataServiceProviderProtocol!
    var cancellables = Set<AnyCancellable>()
    init(serviceProvider: DataServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
    }
    
    func get() async throws -> ContentWrapper<[Content]> {
        return try await withCheckedThrowingContinuation { continuation in
            self
                .serviceProvider
                .request(from: APIEndpoint(
                    method: .get,
                    endURL: .movies), of: ContentWrapper<[Content]>.self)
            // if it fails : request data from cache
                .sink(receiveCompletion: { completion1 in
                    switch completion1 {
                        case .finished :
                            break
                        case .failure(let error) :
                            
                            // lets try from cache
                            if let cachedData = CacheManager.shared.get(folderType: .movies, identifier: APIProvider.movies.rawValue) {
                                do {
                                    let content = try JSONDecoder().decode(ContentWrapper<[Content]>.self, from: cachedData)
                                    continuation.resume(with: .success(content))
                                } catch let error {
                                    continuation.resume(throwing: error)
                                }
                            } else {
                                
                                // loaded from cache else throw failed
                                continuation.resume(throwing: error)
                            }
                    }
                }, receiveValue: { content in
                    // when we get data : we need to save it in cache
                    if let data = try? JSONEncoder().encode(content) {
                        _ = CacheManager.shared.save(folderType: .movies, identifier: APIProvider.movies.rawValue, content: data)
                    }
                    continuation.resume(with: .success(content))
                })
                .store(in: &cancellables)
        }
    }
}

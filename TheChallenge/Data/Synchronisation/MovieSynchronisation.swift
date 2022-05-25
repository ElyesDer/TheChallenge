//
//  MovieSynchronisation.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 25/05/2022.
//

import Foundation
import Combine

class MovieSynchronisation: MovieRepository {
    typealias Entity = Movie
    
    var serviceProvider: DataServiceProviderProtocol!
    var cancellables = Set<AnyCancellable>()
    init(serviceProvider: DataServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
    }
    
    func get(url path: String, filePath: String) async throws -> Movie {
        return try await withCheckedThrowingContinuation { continuation in
            self
                .serviceProvider
                .request(from: APIEndpoint(
                    method: .get,
                    endURL: .custom(path)), of: Movie.self)
            // if it fails : request data from cache
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished :
                            break
                        case .failure(let error) :
                            
                            // lets try from cache
                            if let cachedData = CacheManager.shared.get(folderType: .movies, identifier: filePath) {
                                do {
                                    let content = try JSONDecoder().decode(Movie.self, from: cachedData)
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
                        _ = CacheManager.shared.save(folderType: .movies, identifier: filePath, content: data)
                    }
                    continuation.resume(with: .success(content))
                })
                .store(in: &cancellables)
        }
    }
}

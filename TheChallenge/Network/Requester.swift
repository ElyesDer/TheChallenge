//
//  Requester.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import Combine

protocol ResponseWrapper: Decodable { }

protocol DataServiceProviderProtocol {
    func request<T: Decodable>(from provider: NetworkProvider, of type: T.Type) -> AnyPublisher<T, Error>
}

class Requester: DataServiceProviderProtocol {
    
    enum ServiceError: Error {
        case url(URLError)
        case urlRequest
        case decode
    }
    
    /// Perform `HTTP` `GET` Request using a Generic Network Provider
    /// - Parameters:
    ///   - provider: conform to `NetworkProvider`, a generic API Endpoint configuration
    ///   - type: Expected Type from the Endpoint
    /// - Returns: `Publisher` subscription
    func request<T>(from provider: NetworkProvider, of type: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        var dataTask: URLSessionDataTask?
        
        // Init Publisher subscriptions
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<T, Error> { fallback in
            
            guard let urlRequest: URLRequest = try? provider.buildURLRequest() else {
                fallback(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        fallback(.failure(error))
                    }
                    return
                }
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    fallback(.success(responseData))
                } catch {
                    fallback(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

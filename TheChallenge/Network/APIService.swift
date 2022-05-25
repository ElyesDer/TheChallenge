//
//  APIService.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

public protocol NetworkProvider {
    var method: HTTPMethods { get }
    var endURL: APIProvider { get }
    
    func buildURLRequest() throws -> URLRequest
}

public enum APIProvider {
    
    private var baseUrl: String {
        "https://static.canal-plus.net/ios_test/"
    }
    
    case movies
    
    case custom(String)
    
    var rawValue: String {
        switch self {
            case .custom(let path):
                return path
        case .movies:
            return baseUrl + "movies.json"
        }
    }
}

public enum HTTPMethods: String {
    case get = "GET"
}

public struct APIEndpoint: NetworkProvider {
    
    enum NetworkProviderError: Error {
        case urlBuilder
        case urlRequest
    }
    
    public var method: HTTPMethods
    public let endURL: APIProvider
    
    public init(method: HTTPMethods,
                endURL: APIProvider) {
        self.method = method
        self.endURL = endURL
    }
    
    public func buildURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.endURL.rawValue) else { throw NetworkProviderError.urlBuilder }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }    
}

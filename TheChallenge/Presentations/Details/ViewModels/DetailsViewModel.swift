//
//  DetailsViewModel.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 21/05/2022.
//

import Foundation
import Combine

class DetailsViewModel {
    
    let path: String
    
    @Published
    var movie: Movie? = nil
    
    var imageHeader: String? = nil
    var imagePreview: String? = nil
    var title: String? = nil
    var description: String? = nil
    var rating: Double? = nil
    var cast: String? = nil
    var year: String? = nil
    var length: String? = nil
    var subdetails: String? = nil
    
    var serviceProvider : DataServiceProviderProtocol!
    
    var cancellables = Set<AnyCancellable>()
    
    init(from path: String, using serviceProvider: DataServiceProviderProtocol = Requester()) {
        // load content form path
        self.path = path
        self.serviceProvider = serviceProvider
    }
    
    func viewDidLoad() {
        // load url content
        serviceProvider
            .request(from: APIEndpoint(
                method: .get,
                endURL: .custom(self.path)), of: Movie.self)
            .sink { completion in
                switch completion {
                    case .finished : break
                    case .failure(let error) :
                        print(error)
                }
            } receiveValue: { movie in
                self.imageHeader = movie.imageURL
                self.imagePreview = movie.channelLogoURL
                self.title = movie.title
                self.subdetails = movie.subtitle
                self.description = movie.summary
                self.rating = movie.reviews.map { $0.stars.value }.first ?? 0.0
                self.year = movie.productionYear
                self.length = movie.duration
                self.cast = movie.personnalities.flatMap { $0.personnalitiesList }.joined(separator: ", ")
                self.movie = movie
            }
            .store(in: &cancellables)

    }
}

//
//  DetailsViewModel.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 21/05/2022.
//

import Foundation
import Combine

class DetailsViewModel {
    
    enum DetailsViewModelLoadingState {
        case loading
        case failed(String)
        case loaded
        case idle
    }
    
    let path: String
    
    @Published
    var movie: Movie?
    
    var imageHeader: String?
    var imagePreview: String?
    var title: String?
    var description: String?
    var rating: Double?
    var cast: String?
    var year: String?
    var length: String?
    var subdetails: String?
    
    var serviceProvider : DataServiceProviderProtocol!
    
    var cancellables = Set<AnyCancellable>()
    
    @Published
    var loadingState: DetailsViewModelLoadingState = .idle
    
    init(from path: String, using serviceProvider: DataServiceProviderProtocol = Requester()) {
        // load content form path
        self.path = path
        self.serviceProvider = serviceProvider
    }
    
    func viewDidLoad() {
        // load url content
        loadingState = .loading
        serviceProvider
            .request(from: APIEndpoint(
                method: .get,
                endURL: .custom(self.path)), of: Movie.self)
            .sink { completion in
                switch completion {
                    case .finished :
                        self.loadingState = .loaded
                        break
                    case .failure(let error) :
                        self.loadingState = .failed(error.localizedDescription)
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

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
    
    let urlPage: String
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
    
    var cancellables = Set<AnyCancellable>()
    
    @Published
    var loadingState: DetailsViewModelLoadingState = .idle
    
    var serviceProvider: DataServiceProviderProtocol!
    var synchronisation: MovieSynchronisation!
    
    init(from urlPage: String, with path: String, using serviceProvider: DataServiceProviderProtocol = Requester()) {
        self.serviceProvider = serviceProvider
        self.synchronisation = .init(serviceProvider: serviceProvider)
        // load content form path
        self.urlPage = urlPage
        self.serviceProvider = serviceProvider
        self.path = path
    }
    
    func viewDidLoad() {
        // load url content
        loadingState = .loading
        
        Task {
            do {
                let movie = try await self.synchronisation
                    .get(url: self.urlPage, filePath: self.path)
                DispatchQueue.main.async {
                    self.imageHeader = movie.imageURL
                    self.imagePreview = movie.channelLogoURL
                    self.title = movie.title
                    self.subdetails = movie.editorialTitle
                    self.description = movie.summary
                    self.rating = movie.reviews.map { $0.stars.value }.first ?? 0.0
                    self.year = movie.productionYear
                    self.length = movie.duration
                    self.cast = movie.personnalities.flatMap { $0.personnalitiesList }.joined(separator: ", ")
                    self.movie = movie
                    self.loadingState = .loaded
                }
            } catch {
                // error handling
                self.loadingState = .failed(error.localizedDescription)
            }
        }
        
//        serviceProvider
//            .request(from: APIEndpoint(
//                method: .get,
//                endURL: .custom(self.urlPage)), of: Movie.self)
//            .sink { completion in
//                switch completion {
//                    case .finished :
//                        self.loadingState = .loaded
//                        break
//                    case .failure(let error) :
//                        self.loadingState = .failed(error.localizedDescription)
//                }
//                
//            } receiveValue: { movie in
//                self.imageHeader = movie.imageURL
//                self.imagePreview = movie.channelLogoURL
//                self.title = movie.title
//                self.subdetails = movie.editorialTitle
//                self.description = movie.summary
//                self.rating = movie.reviews.map { $0.stars.value }.first ?? 0.0
//                self.year = movie.productionYear
//                self.length = movie.duration
//                self.cast = movie.personnalities.flatMap { $0.personnalitiesList }.joined(separator: ", ")
//                self.movie = movie
//            }
//            .store(in: &cancellables)
    }
}

//
//  MovieDataModel.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import Combine
import Foundation

final class MovieDataModel {
    private var cancellables = Set<AnyCancellable>()
    private let client: APIClient
    
    @Published var movies: [Movie] = []
    var selectedOption: Int! {
        willSet {
            guard let option = Option(rawValue: newValue) else {
                return
            }
            load(option: option)
        }
    }
    
    init(client: APIClient) {
        self.client = client
    }
    
    private func load(option: Option) {
        client
            .retrieveMovies(option: option)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error) // This is usually a product question whether to surface the error, or keep trying.
                }
            }, receiveValue: { movies in
                self.movies = movies
            })
            .store(in: &cancellables)
    }
    
    func load(movie: Int) -> AnyPublisher<MovieDetail, APIClientError> {
        // Since we are not expecting this to change, we can pass
        // The movie detail along
        client
            .retrieveMovieDetail(id: movie)
    }
    
    enum Option: Int, CustomStringConvertible {
        case popular
        case topRated
        case upcoming
        
        var description: String {
            switch self {
            case .popular:
                return "Popular"
            case .topRated:
                return "Top Rated"
            case .upcoming:
                return "Upcoming"
            }
        }
        
        var key: String {
            switch self {
            case .popular:
                return "popular"
            case .topRated:
                return "top_rated"
            case .upcoming:
                return "upcoming"
            }
        }
    }
}

extension MovieDataModel: ObservableObject {}

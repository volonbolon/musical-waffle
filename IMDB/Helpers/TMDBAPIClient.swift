//
//  TMDBAPIClient.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 22/07/2021.
//

import Combine
import Foundation
import VolonbolonKit

struct TMDBAPIClient: APIClient {
    private let manager: APIManager
    private var cancellables = Set<AnyCancellable>()
    
    init(manager: APIManager = VolonbolonKit.Networking.Manager()) {
        self.manager = manager
    }
    
    func retrieveMovies(option: MovieDataModel.Option) -> AnyPublisher<[Movie], APIClientError> {
        let path = "3/movie/\(option.key)"
        guard let url = URLBuilder()
                .set(scheme: "https")
                .set(host: "api.themoviedb.org")
                .set(path: path)
                .addQueryItem(name: "api_key", value: Constants.apiKey)
                .build() else {
            return Fail<[Movie], APIClientError>(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        return manager.loadData(from: url)
            .decode(type: MovieResults.self, decoder: JSONDecoder())
            .mapError({ error in
                APIClientError.error(error)
            })
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    func retrieveMovieDetail(id: Int) -> AnyPublisher<MovieDetail, APIClientError> {
        let path = "3/movie/\(id)"
        guard let url = URLBuilder()
                .set(scheme: "https")
                .set(host: "api.themoviedb.org")
                .set(path: path)
                .addQueryItem(name: "api_key",
                              value: Constants.apiKey)
                .addQueryItem(name: "append_to_response",
                              value: "videos")
                .build() else {
            return Fail<MovieDetail, APIClientError>(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        return manager.loadData(from: url)
            .decode(type: MovieDetail.self, decoder: JSONDecoder())
            .mapError({ error in
                APIClientError.error(error)
            })
            .eraseToAnyPublisher()
    }
    
    func retrieveTVShows(option: TVShowDataModel.Option) -> AnyPublisher<[TVShow], APIClientError> {
        let path = "3/tv/\(option.key)"
        guard let url = URLBuilder()
                .set(scheme: "https")
                .set(host: "api.themoviedb.org")
                .set(path: path)
                .addQueryItem(name: "api_key", value: Constants.apiKey)
                .build() else {
            return Fail<[TVShow], APIClientError>(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        return manager.loadData(from: url)
            .decode(type: TVShowResults.self, decoder: JSONDecoder())
            .mapError({ error in
                APIClientError.error(error)
            })
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    func retrieveTVShowDetail(id: Int) -> AnyPublisher<TVShowDetail, APIClientError> {
        let path = "3/tv/\(id)"
        guard let url = URLBuilder()
                .set(scheme: "https")
                .set(host: "api.themoviedb.org")
                .set(path: path)
                .addQueryItem(name: "api_key",
                              value: Constants.apiKey)
                .addQueryItem(name: "append_to_response",
                              value: "videos")
                .build() else {
            return Fail<TVShowDetail, APIClientError>(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        return manager.loadData(from: url)
            .decode(type: TVShowDetail.self, decoder: JSONDecoder())
            .mapError({ error in
                APIClientError.error(error)
            })
            .eraseToAnyPublisher()
    }
    
    private struct Constants {
        static let apiKey: String = "2423ee617cce82d2609e3495aec1ee71"
    }
}

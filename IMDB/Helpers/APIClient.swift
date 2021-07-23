//
//  APIClient.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 21/07/2021.
//

import Combine
import Foundation

enum APIClientError: Error {
    case addressUnreachable(URL)
    case error(Error)
    case invalidResponse
    case invalidURL
}

extension APIClientError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Unable to build URL",
                                     comment: "Unable to build URL")
        case .error(let error):
            return error.localizedDescription
        case .invalidResponse:
            return NSLocalizedString("Unable to parse response",
                                     comment: "Unable to parse response")
        case .addressUnreachable(let url):
            let format = NSLocalizedString("Unable to reach %s",
                                           comment: "Unable to reach")
            return String(format: format, url.absoluteString)
        }
    }
}

extension APIClientError: Identifiable {
    var id: String {
        return localizedDescription
    }
}

protocol APIClient {
    func retrieveMovies(option: MovieDataModel.Option) -> AnyPublisher<[Movie], APIClientError>
    func retrieveMovieDetail(id: Int) -> AnyPublisher<MovieDetail, APIClientError>
    func retrieveTVShows(option: TVShowDataModel.Option) -> AnyPublisher<[TVShow], APIClientError>
    func retrieveTVShowDetail(id: Int) -> AnyPublisher<TVShowDetail, APIClientError>
}

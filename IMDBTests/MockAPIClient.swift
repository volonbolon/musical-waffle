//
//  MockAPIClient.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 21/07/2021.
//

@testable import IMDB
import Combine
import Foundation
import UIKit

struct MockAPIClient: APIClient {
    func pathForResource(name: String, ofType type: String) -> String? {
        for bundle in Bundle.allBundles {
            if let path = bundle.path(forResource: name, ofType: type) {
                return path
            }
        }
        return nil
    }
    
    func retrieveMovies(option: MovieDataModel.Option) -> AnyPublisher<[Movie], APIClientError> {
        let resource: String
        switch option {
        case .topRated:
            resource = "TopRatedMovie"
        default:
            resource = "\(option.description)Movie"
        }
        
        guard let path = pathForResource(name: resource, ofType: ".json") else {
            return Just([])
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let payload = try JSONDecoder().decode(Results.self, from: data)
            return Just(payload.results)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<[Movie], APIClientError>(error: .invalidResponse)
                .eraseToAnyPublisher()
        }
    }
    
    func retrieveMovieDetail(id: Int) -> AnyPublisher<MovieDetail, APIClientError> {
        guard let path = pathForResource(name: "MovieDetail", ofType: ".json") else {
            return Fail<MovieDetail, APIClientError>(error: .addressUnreachable(URL(string: "MovieDetail.json")!))
                .eraseToAnyPublisher()
                    
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let payload = try JSONDecoder().decode(MovieDetail.self, from: data)
            return Just(payload)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<MovieDetail, APIClientError>(error: .invalidResponse)
                .eraseToAnyPublisher()
        }
    }
}

//
//  TVShowDataModel.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Combine
import Foundation

final class TVShowDataModel {
    private var cancellables = Set<AnyCancellable>()
    private let client: APIClient
    
    @Published var shows: [TVShow] = []
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
            .retrieveTVShows(option: option)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error) // This is usually a product question whether to surface the error, or keep trying.
                }
            }, receiveValue: { shows in
                self.shows = shows
            })
            .store(in: &cancellables)
    }
    
    func load(tvShow: Int) -> AnyPublisher<TVShowDetail, APIClientError> {
        client
            .retrieveTVShowDetail(id: tvShow)
    }
    
    enum Option: Int, CustomStringConvertible {
        case popular
        case topRated
        
        var description: String {
            switch self {
            case .popular:
                return "Popular"
            case .topRated:
                return "Top Rated"
            }
        }
        
        var key: String {
            switch self {
            case .popular:
                return "popular"
            case .topRated:
                return "top_rated"
            }
        }
    }
}

extension TVShowDataModel: ObservableObject {}

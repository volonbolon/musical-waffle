//
//  TVShow.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Foundation

final class TVShowResults: Codable {
    let results: [TVShow]
}

final class TVShow: Codable {
    let backdropID: String?
    let id: Int
    let originalTitle: String
    let overview: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    var backdrop: URL? {
        if let backdrop = backdropID, let url = URL(string: "https://image.tmdb.org/t/p/w342/\(backdrop)") {
            return url
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropID = "backdrop_path"
        case id
        case originalTitle = "original_name"
        case overview
        case title = "name"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension TVShow: Identifiable {}

extension TVShow: ObservableObject {}

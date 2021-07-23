//
//  Movie.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import Foundation

final class MovieResults: Codable {
    let results: [Movie]
}

final class Movie {
    let backdropID: String?
    let id: Int
    let originalTitle: String
    let overview: String
    let releaseDate: Date?
    let title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropID = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.backdropID = try container.decodeIfPresent(String.self, forKey: .backdropID)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        if let releaseDateRaw = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            let formatter = DateFormatter.yyMMdd
            if let date = formatter.date(from: releaseDateRaw) {
                releaseDate = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .releaseDate,
                                                       in: container,
                                                       debugDescription: "Date string does not match format expected by formatter.")
            }
        } else {
            releaseDate = nil
        }
        self.title = try container.decode(String.self, forKey: .title)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}

extension Movie: Identifiable {}

extension Movie: Codable {}

extension Movie: ObservableObject {}

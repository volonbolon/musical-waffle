//
//  TVShowDetail.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Foundation

// We can abstract some of the properties like genres and video to a
// parent class to use here and with movide detail
final class TVShowDetail: Codable {
    let genres: [Genre]
    let homepage: URL?
    let id: Int
    let name: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let overview: String
    let posterID: String
    let seasons: [Season]
    let videos: [Video]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        let rawHomepage = try container.decode(String.self, forKey: .homepage)
        self.homepage = URL(string: rawHomepage)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.numberOfEpisodes = try container.decode(Int.self, forKey: .numberOfEpisodes)
        self.numberOfSeasons = try container.decode(Int.self, forKey: .numberOfSeasons)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterID = try container.decode(String.self, forKey: .posterID)
        self.seasons = try container.decode([Season].self, forKey: .seasons)
        let rawVideos = try container.decode(VideoResults.self, forKey: .videos)
        self.videos = rawVideos.results
    }
    
    var posterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w342/\(posterID)")
    }

    enum CodingKeys: String, CodingKey {
        case genres
        case homepage
        case id
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case overview
        case posterID = "poster_path"
        case seasons
        case videos
    }
    
    struct Genre: Codable {
        let id: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }
    
    struct Season: Codable {
        let episodeCount: Int
        let id: Int
        let name: String
        let overview: String
        let seasonNumber: Int
        
        enum CodingKeys: String, CodingKey {
            case episodeCount = "episode_count"
            case id
            case name
            case overview
            case seasonNumber = "season_number"
        }
    }
    
    struct Video: Codable {
        let key: String
        let name: String
        let site: String
        
        var url: URL? {
            switch site {
            case "YouTube":
                return URL(string: "https://www.youtube.com/watch?v=\(key)")
            case "Vimeo":
                return URL(string: "https://vimeo.com/\(key)")
            default:
                return nil
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case key
            case name
            case site
        }
    }
    
    struct VideoResults: Codable {
        let results: [Video]
        
        enum CodingKeys: String, CodingKey {
            case results
        }
    }
}

extension TVShowDetail: Identifiable {}

extension TVShowDetail: ObservableObject {}

//
//  MovieDetail.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 22/07/2021.
//

import Foundation

final class MovieDetail {
    let genres: [Genre]
    let homepage: URL?
    let id: Int
    let overview: String
    let posterID: String
    let title: String
    let videos: [Video]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        let rawHomepage = try container.decode(String.self, forKey: .homepage)
        self.homepage = URL(string: rawHomepage)
        self.id = try container.decode(Int.self, forKey: .id)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterID = try container.decode(String.self, forKey: .posterID)
        self.title = try container.decode(String.self, forKey: .title)
        let rawVideos = try container.decode(VideoResults.self, forKey: .videos)
        self.videos = rawVideos.results
    }
    
    var posterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w342/\(posterID)")
    }
    
    struct Genre: Codable {
        let id: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
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
    
    enum CodingKeys: String, CodingKey {
        case genres
        case homepage
        case id
        case overview
        case title
        case videos
        case posterID = "poster_path"
    }
}

extension MovieDetail: Identifiable {}

extension MovieDetail: Codable {}

extension MovieDetail: ObservableObject {}

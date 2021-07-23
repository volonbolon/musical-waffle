//
//  MovieDetailInteractor.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 22/07/2021.
//

import Foundation

class MovieDetailInteractor {
    let model: MovieDataModel
    let movieID: Int
    
    init(model: MovieDataModel, movieID: Int) {
        self.model = model
        self.movieID = movieID
    }
}

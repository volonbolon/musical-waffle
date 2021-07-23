//
//  MovieListInteractor.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import Foundation
 
protocol MovieListInteractorType {
    var model: MovieDataModel { get }
}

class MovieListInteractor: MovieListInteractorType {
    let model: MovieDataModel
    
    init(model: MovieDataModel) {
        self.model = model
    }
}

//
//  TVShowListInteractor.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Foundation

protocol TVShowListInteractorType {
    var model: TVShowDataModel { get }
}

class TVShowListInteractor: TVShowListInteractorType {
    let model: TVShowDataModel
    
    init(model: TVShowDataModel) {
        self.model = model
    }
}

//
//  TVShowDetailInteractor.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Foundation

final class TVShowDetailInteractor {
    let model: TVShowDataModel
    let showID: Int
    
    init(model: TVShowDataModel, showID: Int) {
        self.model = model
        self.showID = showID
    }
}

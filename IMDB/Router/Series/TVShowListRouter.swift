//
//  TVShowListRouter.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import SwiftUI

class TVShowListRouter {
    func makeDetailView(for showID: Int,
                        model: TVShowDataModel) -> some View {
        let interactor = TVShowDetailInteractor(model: model, showID: showID)
        let presenter = TVShowDetailPresenter(interactor: interactor)
        return TVShowDetailView(presenter: presenter)
    }
}

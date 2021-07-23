//
//  MovieListRouter.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import SwiftUI

class MovieListRouter {
    func makeDetailView(for movie: Int,
                        model: MovieDataModel) -> some View {
        let interactor = MovieDetailInteractor(model: model, movieID: movie)
        let presenter = MovieDetailPresenter(interactor: interactor)
        return MovieDetailView(presenter: presenter)
  }
}

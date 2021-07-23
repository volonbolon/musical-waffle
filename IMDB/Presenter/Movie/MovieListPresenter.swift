//
//  MovieListPresenter.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import Combine
import SwiftUI

class MovieListPresenter: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let interactor: MovieListInteractorType
    private let router: MovieListRouter
    
    @Published var movies: [MovieList] = []
    
    init(interactor: MovieListInteractorType,
         router: MovieListRouter) {
        self.interactor = interactor
        self.router = router
        
        interactor.model.$movies
            .map({ movies -> [MovieList] in
                return movies.compactMap { movie -> MovieList? in
                    let releaseDate: String = {
                        if let movieReleaseDate = movie.releaseDate {
                            return DateFormatter.yy.string(from: movieReleaseDate)
                        }
                        return ""
                    }()
                    let backdrop: URL? = {
                        if let backdrop = movie.backdropID, let url = URL(string: "https://image.tmdb.org/t/p/w342/\(backdrop)") {
                            return url
                        }
                        return nil
                    }()
                    return MovieList(backdrop: backdrop,
                                     id: movie.id,
                                     releaseDate: releaseDate,
                                     title: movie.title,
                                     voteAverage: movie.voteAverage)
                }
            })
            .assign(to: \.movies, on: self)
            .store(in: &cancellables)
    }
    
    func makeSelectionPicker() -> some View {
        MovieSelectionPicker(selectedOption: Binding(get: {
            self.interactor.model.selectedOption
        }, set: { val in
            self.interactor.model.selectedOption = val
        }))
    }
    
    func linkBuilder<Content: View>(for movie: MovieListPresenter.MovieList,
                                    @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(for: movie.id,
                                                          model: interactor.model),
                       label: {
                        content()
                       })
    }
    
    struct MovieList {
        let backdrop: URL?
        let id: Int
        let releaseDate: String
        let title: String
        let voteAverage: Double
    }
}

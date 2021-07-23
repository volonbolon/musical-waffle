//
//  MovieDetailPresenter.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 22/07/2021.
//

import Combine
import Foundation

class MovieDetailPresenter: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let interactor: MovieDetailInteractor

    @Published var movie: MovieDetail?
    
    init(interactor: MovieDetailInteractor) {
        self.interactor = interactor
    }
    
    func loadMovie() {
        interactor.model.load(movie: interactor.movieID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            }, receiveValue: { movie in
                self.movie = movie
            })
            .store(in: &cancellables)
    }
}

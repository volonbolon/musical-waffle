//
//  TVShowDetailPresenter.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Combine
import Foundation

final class TVShowDetailPresenter: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let interactor: TVShowDetailInteractor

    @Published var show: TVShowDetail?
    
    init(interactor: TVShowDetailInteractor) {
        self.interactor = interactor
    }
    
    func loadTVShow() {
        interactor.model.load(tvShow: interactor.showID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            }, receiveValue: { show in
                self.show = show
            })
            .store(in: &cancellables)
    }
}

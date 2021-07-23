//
//  TVShowListPresenter.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import Combine
import SwiftUI

final class TVShowListPresenter: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let interactor: TVShowListInteractorType
    private let router: TVShowListRouter
    
    @Published var shows: [TVShow] = []
    
    init(interactor: TVShowListInteractorType, router: TVShowListRouter) {
        self.interactor = interactor
        self.router = router
        
        interactor.model.$shows
            .assign(to: \.shows, on: self)
            .store(in: &cancellables)
    }
    
    func makeSelectionPicker() -> some View {
        TVShowSelectionPicker(selectedOption: Binding(get: {
            self.interactor.model.selectedOption
        }, set: { val in
            self.interactor.model.selectedOption = val
        }))
    }
    
    func linkBuilder<Content: View>(for show: TVShow,
                                    @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: show.id,
                                               model: interactor.model),
            label: {
                content()
            })
    }
}

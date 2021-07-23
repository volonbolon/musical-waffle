//
//  MovieListView.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var presenter: MovieListPresenter
    
    var body: some View {
        List {
            ForEach(presenter.movies, id: \.id) { movie in
                self.presenter
                    .linkBuilder(for: movie) {
                        MovieListCell(movie: movie)
                            .frame(height: 160)
                    }
            }
        }
        .navigationBarTitle("Movies")
        .navigationBarItems(trailing: presenter.makeSelectionPicker())
    }
}

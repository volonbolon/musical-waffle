//
//  SeriesListView.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import SwiftUI

struct SeriesListView: View {
    var presenter: TVShowListPresenter
    
    var body: some View {
        List {
            ForEach(presenter.shows, id: \.id) { show in
                self.presenter.linkBuilder(for: show) {
                    TVShowListCell(show: show)
                        .frame(height: 160)
                }
            }
        }
        .navigationBarTitle("TV Shows")
        .navigationBarItems(trailing: presenter.makeSelectionPicker())
    }
}

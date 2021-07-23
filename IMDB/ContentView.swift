//
//  ContentView.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var movieModel: MovieDataModel
    @EnvironmentObject var tvShowModel: TVShowDataModel
    var body: some View {
        TabView {
            NavigationView {
                AppDependencyContainer.makeMovieListView(movieModel: movieModel)
            }
            .tabItem {
                Label("Movies",
                      systemImage: "film")
            }
            
            NavigationView {
                AppDependencyContainer.makeTVShowsListView(model: tvShowModel)
            }
            .tabItem {
                Label("Series",
                      systemImage: "tv")
            }
        }
    }
}

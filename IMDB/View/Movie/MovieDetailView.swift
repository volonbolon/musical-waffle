//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var presenter: MovieDetailPresenter
    @Environment(\.openURL) var openURL
    
    var body: some View {
        if let movie = presenter.movie {
            ScrollView(.vertical, showsIndicators: false, content: {
                Text(movie.overview)
                    .font(.caption)
                    .padding()
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(alignment: .center, spacing: 8, content: {
                        ForEach(movie.genres, id: \.id) { genre in
                            Text(genre.name)
                                .font(.callout)
                        }
                    })

                })
                .padding()
                if let url = movie.homepage {
                    Button(action: {
                        openURL(url)
                    }, label: {
                        Text("Open Homepage")
                    })
                }
                if let url = movie.posterURL {
                    RemoteImage(url: url)
                        .scaledToFit()
                        .frame(width: 340)
                }
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .leading, spacing: 8, content: {
                        // Here we should be able to embed a video with
                        // https://developer.apple.com/documentation/avkit/videoplayer
                        ForEach(movie.videos, id: \.key) { video in
                            if let url = video.url {
                                Button(action: {
                                    openURL(url)
                                }, label: {
                                    Text(video.name)
                                })
                            }
                        }
                    })
                })
                .padding()
            })
            .navigationTitle(movie.title)
        } else {
            Text("Loading...")
                .onAppear(perform: {
                    fetch()
                })
        }
    }
    
    private func fetch() {
        presenter.loadMovie()
    }
}

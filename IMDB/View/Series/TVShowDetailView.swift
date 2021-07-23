//
//  TVShowDetailView.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import SwiftUI

struct SeasonView: View {
    var season: TVShowDetail.Season
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(alignment: .center, content: {
                Text(season.name)
                    .font(.caption)
                Spacer()
                Text("Season: \(season.seasonNumber) | \(season.episodeCount) episodes")
                    .font(.caption2)
            })
            .padding()
            Text(season.overview)
                .font(.callout)
                .padding()
        })
    }
}

struct TVShowDetailView: View {
    @ObservedObject var presenter: TVShowDetailPresenter
    @Environment(\.openURL) var openURL
    
    var body: some View {
        if let show = presenter.show {
            ScrollView(.vertical, showsIndicators: false, content: {
                Text(show.overview)
                    .font(.caption)
                    .padding()
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(alignment: .center, spacing: 8, content: {
                        ForEach(show.genres, id: \.id) { genre in
                            Text(genre.name)
                                .font(.callout)
                        }
                    })

                })
                .padding()
                
                if let url = show.homepage {
                    Button(action: {
                        openURL(url)
                    }, label: {
                        Text("Open Homepage")
                    })
                }
                
                if let url = show.posterURL {
                    RemoteImage(url: url)
                        .scaledToFit()
                        .frame(width: 340)
                }
                
                VStack(alignment: .leading, content: {
                    ForEach(show.seasons, id: \.id) { season in
                        SeasonView(season: season)
                    }
                })
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .leading, spacing: 8, content: {
                        // Here we should be able to embed a video with
                        // https://developer.apple.com/documentation/avkit/videoplayer
                        ForEach(show.videos, id: \.key) { video in
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
            .navigationTitle(show.name)
        } else {
            Text("Loading...")
                .onAppear(perform: {
                    fetch()
                })
        }
    }
    
    private func fetch() {
        presenter.loadTVShow()
    }
}

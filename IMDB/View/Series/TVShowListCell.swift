//
//  TVShowListCell.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import SwiftUI

struct TVShowTitleLabel: View {
    var votes: String
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .font(.title)
            VoteLabel(votes: "\(votes)")
        })
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 4, trailing: 8))
    }
}

struct TVShowListCell: View {
    var show: TVShow
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading, content: {
                Color.black
                if let url = show.backdrop {
                    RemoteImage(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                BlurView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                TVShowTitleLabel(votes: "\(show.voteAverage)",
                                 title: show.title)
            })
        }
    }
}

//
//  MovieListCell.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 20/07/2021.
//

import SwiftUI
import Combine

struct ReleaseDateLabel: View {
    var year: String
    
    var body: some View {
        Text("(\(year))")
            .font(.headline)
    }
}

struct VoteLabel: View {
    var votes: String
    
    var body: some View {
        Text("\(votes)/10")
            .font(.callout)
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
    }
}

struct TitleLabel: View {
    var votes: String
    var title: String
    var year: String
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .font(.title)
            HStack(alignment: .firstTextBaseline, spacing: 8, content: {
                ReleaseDateLabel(year: "\(year)")
                Spacer()
                VoteLabel(votes: "\(votes)")
            })
        })
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 4, trailing: 8))
    }
}

struct MovieListCell: View {
    var movie: MovieListPresenter.MovieList
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading, content: {
                Color.black
                if let url = movie.backdrop {
                    RemoteImage(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .cornerRadius(30)
                }
                BlurView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                TitleLabel(votes: "\(movie.voteAverage)",
                           title: movie.title,
                           year: movie.releaseDate)
            })
        }
    }
}

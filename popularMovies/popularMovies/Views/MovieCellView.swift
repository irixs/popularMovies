//
//  MovieCellView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct MovieCellView: View {
    private let movie: Movie
    init(movie: Movie){
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            //poster
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ZStack{
                    Color.gray.opacity(0.1)
                    Image(systemName: "film")
                        .foregroundColor(Color.gray.opacity(0.5))
                }
            }
            .frame(width: 40, height: 60)
            .cornerRadius(3)
            
            VStack(alignment: .leading){
                //nome
                VStack{
                    Text(movie.title)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Spacer(minLength: 0)
                }.frame(height: 41)
                
                //ano
                Text(String(movie.release_date.prefix(4)))
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieCellView(movie: Movie(genre_ids: [1,3], id: 1, overview: "", poster_path: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", release_date: "2021-12-15", title: "Spider-Man: No Way Home"))
            MovieCellView(movie: Movie(genre_ids: [1,3], id: 1, overview: "", poster_path: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", release_date: "2021-12-15", title: "Spider-Man: No Way Home"))
                .previewDevice("iPhone 11")
        }
    }
}

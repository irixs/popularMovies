//
//  PopularMoviesListView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct PopularMoviesListView: View {
    @StateObject var movies = MovieViewModel()

         var body: some View {
             NavigationView {
                 List {
                     ForEach(movies.movie) { movie in

                         NavigationLink(destination: Text(movie.title)) {
                             MovieCellView(movie: Movie(genre_ids: movie.genre_ids,
                                                        id: movie.id,
                                                        overview: movie.overview,
                                                        poster_path: movie.poster_path,
                                                        release_date: movie.release_date,
                                                        title: movie.title))
                         }
                     }
                 }.navigationBarTitle(Text("Popular Movies"))
             }
         }
     }

struct PopularMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopularMoviesListView()
            PopularMoviesListView()
                .previewDevice("iPhone 11")
        }
    }
}

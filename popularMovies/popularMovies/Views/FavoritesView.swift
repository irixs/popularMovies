//
//  FavoritesView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favorites: Favorites
    @StateObject var movies = MovieViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies.movie) { movie in
                    if self.favorites.contains(movie){
                        NavigationLink(destination:
                                        DetailsView(favorites: favorites, movie: Movie(genre_ids: movie.genre_ids,
                                                                 id: movie.id,
                                                                 overview: movie.overview,
                                                                 poster_path: movie.poster_path,
                                                                 release_date: movie.release_date,
                                                                 title: movie.title)), label: {
                            MovieCellView(movie: Movie(genre_ids: movie.genre_ids,
                                                       id: movie.id,
                                                       overview: movie.overview,
                                                       poster_path: movie.poster_path,
                                                       release_date: movie.release_date,
                                                       title: movie.title))
                        })
                    }
                }
            }.navigationBarTitle(Text("Favorites"))
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favorites: Favorites())
    }
}

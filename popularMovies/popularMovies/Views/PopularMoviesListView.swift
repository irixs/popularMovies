//
//  PopularMoviesListView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct PopularMoviesListView: View {
    @StateObject var movies = MovieViewModel()
    @ObservedObject var favorites: Favorites
    @State private var searchString = ""
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(searchString == "" ? movies.movie : movies.movie.filter { $0.title.lowercased().contains(searchString.lowercased())}) { movie in
                        
                        NavigationLink(destination:
                                        DetailsView(favorites: favorites,
                                                    movie: Movie(genre_ids: movie.genre_ids,
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
                }.searchable(text: $searchString)
                .navigationBarTitle(Text("Popular Movies"))
            }
        }
    }
}

struct PopularMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopularMoviesListView(favorites: Favorites())
            PopularMoviesListView(favorites: Favorites())
                .previewDevice("iPhone 11")
        }
    }
}

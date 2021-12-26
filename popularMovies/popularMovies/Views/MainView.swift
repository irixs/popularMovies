//
//  MainView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var favorites = Favorites()
    
    var body: some View {
        TabView {
            PopularMoviesListView(favorites: favorites)
                .tabItem{
                    Label("Menu",
                          systemImage: "list.and.film")
                }
            FavoritesView(favorites: favorites)
                .tabItem{
                    Label("Favorites",
                          systemImage: "heart.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
            MainView()
                .previewDevice("iPhone 11")
        }
    }
}

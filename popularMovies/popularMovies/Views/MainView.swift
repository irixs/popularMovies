//
//  MainView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            PopularMoviesListView()
                .tabItem{
                    Label("Menu",
                          systemImage: "list.and.film")
                }
            FavoritesView()
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

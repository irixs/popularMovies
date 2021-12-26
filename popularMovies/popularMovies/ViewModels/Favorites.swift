//
//  Favorites.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import Foundation

//import SwiftUI

class Favorites: ObservableObject {
    
    @Published var favMovie: [Movie]
    @Published var favorites: Set<Int> = []
    let defaults = UserDefaults.standard
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Movies") {
            if let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
                self.favMovie = decoded
                return
            }
        }
        self.favMovie = []
        self.favorites = Set(defaults.array(forKey: "Favorites") as? [Int] ?? [])
    }
    func get() -> Int {
        favorites.count
    }
    func contains(_ favMovie: Movie) -> Bool {
        favorites.contains(favMovie.id)
    }
    
    func add(_ favMovie: Movie) {
        favorites.insert(favMovie.id)
        save()
    }
    
    func remove(_ favMovie: Movie) {
        favorites.remove(favMovie.id)
        save()
    }
    
    func save() {
        let encoder = PropertyListEncoder()
                if let encoded = try? encoder.encode(self.favMovie) {
                    self.defaults.set(encoded, forKey: "Recipes")
                }
                self.defaults.set(Array(self.favorites), forKey: "Favorites")
                defaults.synchronize()
    }
}

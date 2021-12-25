//
//  MovieViewModel.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import Foundation
//import SwiftUI
import Combine

class MovieViewModel: ObservableObject {
    
    //private var task: AnyCancellable?
    
    @Published var movie: [Movie] = []
    private var apiKey = "a710326a9ab261da6dd081d0e5bce81f"
    
    init() {
        let baseUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {return}
//            if let err = error {
//                print("Erro to consume", err)
//            }
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data)
                
                DispatchQueue.main.async {
                    self.movie = movies.results
                }
            } catch let error {
                print("Fail to consume api", error)
            }
            
        }.resume()
    }
}

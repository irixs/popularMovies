//
//  GenreViewModel.swift
//  popularMovies
//
//  Created by iris on 26/12/21.
//

import Foundation
import Combine

class GenreViewModel: ObservableObject {
    
    
    @Published var genre: [Genre] = []
    private var apiKey = "a710326a9ab261da6dd081d0e5bce81f"
    
    init() {
        let baseUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)"
        
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {return}
            
            do {
                let genres = try JSONDecoder().decode(Genres.self, from: data)
        
                DispatchQueue.main.async {
                    self.genre = genres.genres
                }
            } catch let error {
                print("Fail to consume genres api", error)
            }
            
        }.resume()
    }
}

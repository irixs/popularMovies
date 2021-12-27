//
//  VideosViewModel.swift
//  popularMovies
//
//  Created by iris on 26/12/21.
//

import Foundation
import Combine
import SwiftUI

class VideosViewModel: ObservableObject {
    
    @Published var video: [Video] = []
    var idMovie: Int = 0
    var charged = false
    private var apiKey = "a710326a9ab261da6dd081d0e5bce81f"
    
    func fetchVideos() {
        let baseUrl = "https://api.themoviedb.org/3/movie/\(idMovie)/videos?api_key=\(apiKey)"
        
        
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {return}
            
            do {
                let videos = try JSONDecoder().decode(Videos.self, from: data)
                
                DispatchQueue.main.async {
                    var x = 0
                    while (x < videos.results.count) {
                        if (videos.results[x].site == "YouTube"){
                            self.video.append(videos.results[x])
                        }
                        x+=1
                    }
                    self.charged.toggle()
                }
            } catch let error {
                print("Fail to consume videos api", error)
            }
            
        }.resume()
    }
}

//
//  Movies.swift
//  popularMovies
//
//  Created by iris on 24/12/21.
//

import Foundation

 struct Movies: Decodable{
     var page: Int
     var results: [Movie]
     var total_pages: Int
     var total_results:Int
 }

 struct Movie: Decodable, Identifiable{
     var genre_ids: [Int]
     var id: Int
     var overview: String
     var poster_path: String
     var release_date: String
     var title: String
 }

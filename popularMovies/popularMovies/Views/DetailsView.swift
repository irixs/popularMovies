//
//  DetailsView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var genres = GenreViewModel()
    @StateObject var videos = VideosViewModel()
    @ObservedObject var favorites: Favorites
    let movie: Movie
    
    var body: some View {
        
        ScrollView{
            
            VStack(alignment: .leading){
                
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.medium)
                
                Text(String(movie.release_date.prefix(4)))
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                HStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ZStack{
                            Color.gray.opacity(0.1)
                            Image(systemName: "photo")
                                .foregroundColor(Color.gray.opacity(0.5))
                                .font(.system(size: 40))
                        }
                    }
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        
                        ForEach(movie.genre_ids.indices) { genre_id in
                            ForEach(genres.genre) { genre in
                                if (movie.genre_ids[genre_id] == genre.id){
                                    Text(genre.name)
                                        .font(.footnote)
                                        .padding(.vertical, 0.5)
                                        .padding(.horizontal, 10)
                                        .background(Color.yellow.opacity(0.3))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                        Button(action: {
                            if self.favorites.contains(self.movie) {
                                self.favorites.remove(self.movie)
                            }
                            else {
                                self.favorites.add(self.movie)
                            }
                            
                        }, label: {
                            Image(systemName: self.favorites.contains(movie) ? "heart.fill" : "heart")
                                .padding(.vertical, 1.0)
                                .font(Font.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.red)
                        })
                        
                        Spacer()
                    }
                }
                
                Text(movie.overview)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                
                Text("Related Videos")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                ScrollView(.horizontal){
                    HStack{
                        if(videos.charged) {
                            ForEach(videos.video.indices) { video in
                                Link(destination: URL(string: "https://www.youtube.com/watch?v=\(videos.video[video].key)")!) {
                                    ZStack {
                                        AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(videos.video[video].key)/0.jpg")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                                Color.gray.opacity(0.1)
                                        }
                                        .frame(width: 150, height: 100)
                                        .cornerRadius(10)
                                        
                                        Image(systemName: "play.circle")
                                            .foregroundColor(Color.white.opacity(0.7))
                                            .font(.system(size: 70))
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }.padding(.horizontal)
            
        }.onAppear{
            videos.idMovie = movie.id
            videos.fetchVideos()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(favorites: Favorites(),
                    movie: Movie(genre_ids: [28, 12, 878],
                                 id: 1,
                                 overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
                                 poster_path: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
                                 release_date: "2021-12-15",
                                 title: "Spider-Man: No Way Home"))
    }
}

//
//  DetailsView.swift
//  popularMovies
//
//  Created by iris on 25/12/21.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var genres = GenreViewModel()
    @ObservedObject var favorites: Favorites
    
    let movie: Movie
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center) {
                
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ZStack{
                        Color.gray.opacity(0.1)
                        Image(systemName: "photo")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .font(.system(size: 80))
                    }
                }
                .cornerRadius(20)
                .frame(width: 380, height: 230)
                
                Text(movie.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .padding(.horizontal)
                
                Text(String(movie.release_date.prefix(4)))
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                
                Button(action: {
                    if self.favorites.contains(self.movie) {
                        self.favorites.remove(self.movie)
                    }
                    else {
                        self.favorites.add(self.movie)
                    }
                    
                }, label: {
                    Image(systemName: self.favorites.contains(movie) ? "heart.fill" : "heart")
                        .font(Font.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.red)
                })
                
                Text(movie.overview)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .bottom, .trailing], 20)
                
                ForEach(movie.genre_ids.indices) { genre_id in
                    ForEach(genres.genre) { genre in
                        if (movie.genre_ids[genre_id] == genre.id){
                            Text(genre.name)
                        }
                    }
                }
                Spacer()
            }
            
        }.onAppear{
            
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

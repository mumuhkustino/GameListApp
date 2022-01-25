//
//  GameFavoriteItem.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import SwiftUI

struct GameFavoriteItem: View {
    
    var game: GameFavoriteViewModel
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string:  "\(game.gameFavorite.gameBackgroundImage ?? "")")!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 120).cornerRadius(10)
            } placeholder: {
                placeHolderImage(width: 100, height: 120)
            }
            
            VStack(alignment: .leading) {
                Text(game.gameFavorite.gameName ?? "")
                    .foregroundColor(.blue)
                    .lineLimit(2)
                    .font(Font.system(size:22))
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                        .frame(width: 20.0, height: 20.0)
                    Text(game.gameFavorite.gameRating.format())
                        .foregroundColor(Color.black)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(Color.blue)
                        .frame(width: 40.0, height: 20.0)
                    Text(game.gameFavorite.gameReleased ?? "").foregroundColor(.black)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .cornerRadius(10)
        .frame(height: 130)
    }
}

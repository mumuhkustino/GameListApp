//
//  GameItem.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

@ViewBuilder
func placeHolderImage(width: CGFloat, height: CGFloat) -> some View {
    HStack(alignment: .center) {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundColor(.gray)
    }
}

struct GameItem: View {
    var game: Game
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: "\(game.backgroundImage)")!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 120).cornerRadius(10)
            } placeholder: {
                placeHolderImage(width: 100, height: 120)
            }
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .foregroundColor(.blue)
                    .lineLimit(2)
                    .font(Font.system(size:22))
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                        .frame(width: 20.0, height: 20.0)
                    Text(game.rating.format())
                        .foregroundColor(Color.black)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(Color.blue)
                        .frame(width: 40.0, height: 20.0)
                    Text(game.released).foregroundColor(.black)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                VStack(alignment: .leading){
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing: 10){
                            ForEach(game.genres) { genre in
                                Text("\(genre.name)")
                                    .foregroundColor(.black)
                                    .font(Font.system(size:16))
                                    .lineLimit(nil)
                                    .padding(4)
                            }
                        } .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(height: 30)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .cornerRadius(10)
        .frame(height: 130)
    }
}

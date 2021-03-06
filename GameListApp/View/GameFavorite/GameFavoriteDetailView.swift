//
//  GameFavoriteDetailView.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import SwiftUI

struct GameFavoriteDetailView: View {
    @State var isFavorite: Bool = true
    var gameId: String
    var bgImage: String
    @ObservedObject var gameFavoriteDetailHelperViewModel = GameFavoriteDetailHelperViewModel()
    @ObservedObject var gameFavoriteDetailViewModel = GameFavoriteDetailViewModel()
    
    init(gameId: String, bgImage: String) {
        self.gameId = gameId
        self.bgImage = bgImage
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if (gameFavoriteDetailViewModel.loading) {
                VStack(alignment: .center) {
                    LoadingIndicator(color: Color.blue, size: 50)
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: "\(self.bgImage)")!) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width,  alignment: .leading)
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: paddingVerticalMedium, leading: 0, bottom: 0, trailing: 0))
                        } placeholder: {
                            placeHolderImage(width: 350, height: 150.0)
                        }
                        Text(gameFavoriteDetailViewModel.gameFavorite.name)
                            .foregroundColor(.blue)
                            .bold()
                            .lineLimit(2)
                            .font(Font.system(size:24))
                        
                        HStack(alignment: .center, spacing: 0) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 24.0, height: 24.0)
                            Text(gameFavoriteDetailViewModel.gameFavorite.rating.format())
                                .foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 0, leading: paddingHorizontalSmall, bottom: 0, trailing: 0))
                            Spacer()
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                            Text(gameFavoriteDetailViewModel.gameFavorite.released)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: paddingHorizontalSmall, bottom: 0, trailing: 0))
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Game Description")
                                .foregroundColor(.blue)
                                .bold()
                                .lineLimit(0)
                                .font(Font.system(size:20))
                                .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: 0, trailing: 0))
                            Text("\(gameFavoriteDetailViewModel.gameFavorite.desc.replacingOccurrences(of: "\r\n", with:"")                                    .replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "<br />", with: "").replacingOccurrences(of: "</p>", with: ""))").multilineTextAlignment(.leading)
                                .font(Font.system(size:18))
                                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width,  alignment: .center)
                                .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: paddingVerticalMedium, trailing: 0))
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .padding(-20)
            }
        }.onAppear {
            self.gameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
        }.navigationBarTitle(Text(gameFavoriteDetailViewModel.gameFavorite.name), displayMode: .inline)
            .navigationBarItems(trailing: isFavorite == false ?
                                Button(action: {
                if self.gameFavoriteDetailViewModel.gameFavorite.id != 0 {
                    self.gameFavoriteDetailHelperViewModel.idInsert = Int32(self.gameFavoriteDetailViewModel.gameFavorite.id)
                    self.gameFavoriteDetailHelperViewModel.nameInsert = self.gameFavoriteDetailViewModel.gameFavorite.name
                    self.gameFavoriteDetailHelperViewModel.ratingInsert = self.gameFavoriteDetailViewModel.gameFavorite.rating
                    self.gameFavoriteDetailHelperViewModel.releasedInsert = self.gameFavoriteDetailViewModel.gameFavorite.released
                    self.gameFavoriteDetailHelperViewModel.descInsert = self.gameFavoriteDetailViewModel.gameFavorite.desc
                    self.gameFavoriteDetailHelperViewModel.backgroundImageInsert = self.gameFavoriteDetailViewModel.gameFavorite.backgroundImage
                    self.gameFavoriteDetailHelperViewModel.backgroundImageAdditionalInsert = self.gameFavoriteDetailViewModel.gameFavorite.backgroundImageAdditional
                    
                    let isFavorite = self.gameFavoriteDetailHelperViewModel.insertGameFavorite()
                    self.isFavorite = isFavorite
                }
            }){
                Image(systemName: "heart")
            } : Button(action:{
                if self.gameFavoriteDetailViewModel.gameFavorite.id != 0 {
                    self.gameFavoriteDetailHelperViewModel.idDelete = self.gameFavoriteDetailViewModel.gameFavorite.id
                    
                    let isNotFavorite = self.gameFavoriteDetailHelperViewModel.deleteGameFavorite()
                    self.isFavorite = !isNotFavorite
                }
            }){
                Image(systemName: "heart.fill")
            }
        )
    }
}

struct GameFavoriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameId: "3498", backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")
    }
}

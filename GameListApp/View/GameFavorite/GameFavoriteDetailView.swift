//
//  GameFavoriteDetailView.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import SwiftUI

struct GameFavoriteDetailView: View {
//    @State var isSaved: Bool = true
    var gameId: String
    var backgroundImage: String
    @ObservedObject var gameDetailViewModel = LoadGameFavoriteDetailViewModel()
    @ObservedObject var addGameFavoriteViewModel = AddGameFavoriteViewModel()
    @ObservedObject var deleteGameFavoriteViewModel = DeleteGameFavoriteViewModel()
    @ObservedObject var loadGameFavoriteDetailViewModel = LoadGameFavoriteDetailViewModel()
    
    init(gameId: String, backgroundImage: String) {
        self.gameId = gameId
        self.backgroundImage = backgroundImage
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if (loadGameFavoriteDetailViewModel.loading) {
                VStack(alignment: .center) {
                    LoadingIndicator(color: Color.blue, size: 50)
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: "\(self.backgroundImage)")!) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width,  alignment: .leading)
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: paddingVerticalMedium, leading: 0, bottom: 0, trailing: 0))
                        } placeholder: {
                            placeHolderImage(width: 350, height: 150.0)
                        }
                        Text(loadGameFavoriteDetailViewModel.gameFavorite.gameName)
                            .foregroundColor(.blue)
                            .bold()
                            .lineLimit(2)
                            .font(Font.system(size:24))
                        
                        HStack(alignment: .center, spacing: 0) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 24.0, height: 24.0)
                            Text(loadGameFavoriteDetailViewModel.gameFavorite.gameRating.format())
                                .foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 0, leading: paddingHorizontalSmall, bottom: 0, trailing: 0))
                            Spacer()
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                            Text(loadGameFavoriteDetailViewModel.gameFavorite.gameReleased)
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
                            Text("\(loadGameFavoriteDetailViewModel.gameFavorite.gameDescription.replacingOccurrences(of: "\r\n", with:"")                                    .replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "<br />", with: "").replacingOccurrences(of: "</p>", with: ""))").multilineTextAlignment(.leading)
                                .font(Font.system(size:18))
                                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width,  alignment: .center)
                                .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: paddingVerticalMedium, trailing: 0))
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .padding(-20)
            }
        }.onAppear {
            self.loadGameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
        }.navigationBarTitle(Text(loadGameFavoriteDetailViewModel.gameFavorite.gameName), displayMode: .inline)
            .navigationBarItems(trailing: self.loadGameFavoriteDetailViewModel.gameFavorite.gameId == 0 || self.loadGameFavoriteDetailViewModel.isFavorite == false ?
                                Button(action: {
                if self.loadGameFavoriteDetailViewModel.gameFavorite.gameId != 0 {
                    self.addGameFavoriteViewModel.gameId = Int32(loadGameFavoriteDetailViewModel.gameFavorite.gameId)
                    self.addGameFavoriteViewModel.gameName = loadGameFavoriteDetailViewModel.gameFavorite.gameName
                    self.addGameFavoriteViewModel.gameRating = loadGameFavoriteDetailViewModel.gameFavorite.gameRating
                    self.addGameFavoriteViewModel.gameReleased = loadGameFavoriteDetailViewModel.gameFavorite.gameReleased
                    self.addGameFavoriteViewModel.gameDescription = loadGameFavoriteDetailViewModel.gameFavorite.gameDescription
                    self.addGameFavoriteViewModel.gameBackgroundImage = loadGameFavoriteDetailViewModel.gameFavorite.gameBackgroundImage
                    self.addGameFavoriteViewModel.gameBackgroundImageAdditional = loadGameFavoriteDetailViewModel.gameFavorite.gameBackgroundImageAdditional
                    
                    let saved = self.addGameFavoriteViewModel.addGameFavorite()
                    if (saved) {
                        self.loadGameFavoriteDetailViewModel.changeFavorite(isFavorite: saved)
                    }
                    self.loadGameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
                }
            }) {
                Image(systemName:"heart")
            }
                                : Button(action: {
                if loadGameFavoriteDetailViewModel.gameFavorite.gameId != 0 {
                    self.deleteGameFavoriteViewModel.gameId = self.loadGameFavoriteDetailViewModel.gameFavorite.gameId
                    
                    let removed = self.deleteGameFavoriteViewModel.deleteGameFavorite()
                    if (removed == true) {
                        self.loadGameFavoriteDetailViewModel.changeFavorite(isFavorite: false)
                    } else {
                        self.loadGameFavoriteDetailViewModel.changeFavorite(isFavorite: true)
                    }
                    self.loadGameFavoriteDetailViewModel.gameFavorite = GameFavorite(gameId: 0, gameName: "", gameRating: 0.0, gameReleased: "", gameDescription: "", gameBackgroundImage: "", gameBackgroundImageAdditional: "")
//                    if (removed) {
//                        self.isSaved = true
//                    } else {
//                        self.isSaved = false
//                    }
                }
            }) {
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

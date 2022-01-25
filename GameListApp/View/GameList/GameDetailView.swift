//
//  GameDetailView.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

struct GameDetailView: View {
//    @State var isSaved = false
    var gameId: String
    var backgroundImage: String
    @ObservedObject var gameDetailViewModel = GameDetailViewModel()
    @ObservedObject var loadGameFavoriteDetailViewModel = LoadGameFavoriteDetailViewModel()
    @ObservedObject var addGameFavoriteViewModel = AddGameFavoriteViewModel()
    @ObservedObject var deleteGameFavoriteViewModel = DeleteGameFavoriteViewModel()
    
    init(gameId: String, backgroundImage: String) {
        self.gameId = gameId
        self.backgroundImage = backgroundImage
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if (gameDetailViewModel.loading) {
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
                        Text(gameDetailViewModel.gameDetail.name)
                            .foregroundColor(.blue)
                            .bold()
                            .lineLimit(2)
                            .font(Font.system(size:24))
                        
                        HStack(alignment: .center, spacing: 0) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 24.0, height: 24.0)
                            Text(gameDetailViewModel.gameDetail.rating.format())
                                .foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 0, leading: paddingHorizontalSmall, bottom: 0, trailing: 0))
                            Spacer()
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                            Text(gameDetailViewModel.gameDetail.released)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: paddingHorizontalSmall, bottom: 0, trailing: 0))
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("Genres")
                            .foregroundColor(.blue)
                            .bold()
                            .lineLimit(2)
                            .font(Font.system(size:20))
                            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width,  alignment: .leading)
                            .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: 0, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 10){
                                    ForEach(gameDetailViewModel.gameDetail.genres) { genre in
                                        Text("\(genre.name)")
                                            .foregroundColor(.black)
                                            .bold()
                                            .font(Font.system(size:16))
                                            .lineLimit(nil)
                                            .padding(EdgeInsets(top: paddingVerticalVerySmall, leading: 0, bottom: 0, trailing: 0))
                                    }
                                } .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .frame(height: 30)
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                        
                        Text("Publishers")
                            .foregroundColor(.blue)
                            .bold()
                            .lineLimit(2)
                            .font(Font.system(size:20))
                            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
                            .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: 0, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 10){
                                    ForEach(gameDetailViewModel.gameDetail.publishers) { publisher in
                                        Text("\(publisher.name)")
                                            .foregroundColor(.black)
                                            .bold()
                                            .font(Font.system(size:16))
                                            .lineLimit(nil)
                                            .padding(EdgeInsets(top: paddingVerticalVerySmall, leading: 0, bottom: 0, trailing: 0))
                                    }
                                } .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .frame(height: 30)
                            } .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Game Description")
                                .foregroundColor(.blue)
                                .bold()
                                .lineLimit(0)
                                .font(Font.system(size:20))
                                .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: 0, trailing: 0))
                            Text("\(gameDetailViewModel.gameDetail.description.replacingOccurrences(of: "\r\n", with:"")                                    .replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "<br />", with: "").replacingOccurrences(of: "</p>", with: ""))").multilineTextAlignment(.leading)
                                .font(Font.system(size:18))
                                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width,  alignment: .center)
                                .padding(EdgeInsets(top: paddingVerticalSmall, leading: 0, bottom: paddingVerticalMedium, trailing: 0))
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .padding(-20)
            }
        }.onAppear {
            self.gameDetailViewModel.loadGameDataById(id: self.gameId)
            self.loadGameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
        }.navigationBarTitle(Text(gameDetailViewModel.gameDetail.name), displayMode: .inline)
            .navigationBarItems(trailing: self.loadGameFavoriteDetailViewModel.gameFavorite.gameId == 0 || self.loadGameFavoriteDetailViewModel.isFavorite == false ?
                                Button(action: {
                if self.gameDetailViewModel.gameDetail.id != 0 {
                    self.addGameFavoriteViewModel.gameId = Int32(self.gameDetailViewModel.gameDetail.id)
                    self.addGameFavoriteViewModel.gameName = self.gameDetailViewModel.gameDetail.name
                    self.addGameFavoriteViewModel.gameRating = self.gameDetailViewModel.gameDetail.rating
                    self.addGameFavoriteViewModel.gameReleased = self.gameDetailViewModel.gameDetail.released
                    self.addGameFavoriteViewModel.gameDescription = self.gameDetailViewModel.gameDetail.description
                    self.addGameFavoriteViewModel.gameBackgroundImage = self.gameDetailViewModel.gameDetail.backgroundImage
                    self.addGameFavoriteViewModel.gameBackgroundImageAdditional = self.gameDetailViewModel.gameDetail.backgroundImageAdditional
//                    var gameGenresLocal: [GameGenreLocal] = []
//                    self.gameDetailViewModel.gameDetail.genres.forEach { gameGenre in
//                        let newGameGenre = GameGenreLocal(context: PersistenceController.shared.managedObjectContext)
//                        newGameGenre.genreId = Int32(gameGenre.id)
//                        newGameGenre.genreName = gameGenre.name
//                        gameGenresLocal.append(newGameGenre)
//                    }
//                    var gamePublishersLocal: [GamePublisherLocal] = []
//                    self.gameDetailViewModel.gameDetail.publishers.forEach { gamePublisher in
//                        let newGamePublisher = GamePublisherLocal(context: PersistenceController.shared.managedObjectContext)
//                        newGamePublisher.publisherId = Int32(gamePublisher.id)
//                        newGamePublisher.publisherName = gamePublisher.name
//                        gamePublishersLocal.append(newGamePublisher)
//                    }
//                    self.addGameFavoriteViewModel.gameGenres = gameGenresLocal
//                    self.addGameFavoriteViewModel.gamePublishers = gamePublishersLocal
//                    self.addGameFavoriteViewModel.gameGenres = self.gameDetailViewModel.gameDetail.genres
//                    self.addGameFavoriteViewModel.gamePublishers = self.gameDetailViewModel.gameDetail.publishers
                    
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
                if self.gameDetailViewModel.gameDetail.id != 0 {
                    self.deleteGameFavoriteViewModel.gameId = Int32(self.gameDetailViewModel.gameDetail.id)
                    
                    let removed = self.deleteGameFavoriteViewModel.deleteGameFavorite()
                    if (removed == true) {
                        self.loadGameFavoriteDetailViewModel.changeFavorite(isFavorite: false)
                    } else {
                        self.loadGameFavoriteDetailViewModel.changeFavorite(isFavorite: true)
                    }
                    self.loadGameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
                }
            }) {
                Image(systemName: "heart.fill")
            }
            )
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameId: "3498", backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")
    }
}

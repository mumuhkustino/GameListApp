//
//  GameDetailView.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

struct GameDetailView: View {
    @State var isFavorite = true
    var gameId: String
    var bgImage: String
    @ObservedObject var gameDetailViewModel = GameDetailViewModel()
    @ObservedObject var gameFavoriteDetailViewModel = GameFavoriteDetailViewModel()
    @ObservedObject var gameFavoriteDetailHelperViewModel = GameFavoriteDetailHelperViewModel()
    
    init(gameId: String, backgroundImage: String) {
        self.gameId = gameId
        self.bgImage = backgroundImage
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
                        AsyncImage(url: URL(string: "\(self.bgImage)")!) { image in
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
            self.gameDetailViewModel.loadGameDetail(gameId: self.gameId)
            self.gameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
        }.navigationBarTitle(Text(gameDetailViewModel.gameDetail.name), displayMode: .inline)
            .navigationBarItems(trailing: self.gameFavoriteDetailViewModel.gameFavorite.id == 0 || !self.isFavorite ?
                                Button(action: {
                if self.gameDetailViewModel.gameDetail.id != 0 {
                    self.gameFavoriteDetailHelperViewModel.idInsert = Int32(self.gameDetailViewModel.gameDetail.id)
                    self.gameFavoriteDetailHelperViewModel.nameInsert = self.gameDetailViewModel.gameDetail.name
                    self.gameFavoriteDetailHelperViewModel.ratingInsert = self.gameDetailViewModel.gameDetail.rating
                    self.gameFavoriteDetailHelperViewModel.releasedInsert = self.gameDetailViewModel.gameDetail.released
                    self.gameFavoriteDetailHelperViewModel.descInsert = self.gameDetailViewModel.gameDetail.description
                    self.gameFavoriteDetailHelperViewModel.backgroundImageInsert = self.gameDetailViewModel.gameDetail.backgroundImage
                    self.gameFavoriteDetailHelperViewModel.backgroundImageAdditionalInsert = self.gameDetailViewModel.gameDetail.backgroundImageAdditional

                    let saved = self.gameFavoriteDetailHelperViewModel.insertGameFavorite()
                    self.isFavorite = saved
                    self.gameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
                }
            }) {
                Image(systemName:"heart")
            }
                                : Button(action: {
                if self.gameDetailViewModel.gameDetail.id != 0 {
                    self.gameFavoriteDetailHelperViewModel.idDelete = Int32(self.gameDetailViewModel.gameDetail.id)
                    
                    let removed = self.gameFavoriteDetailHelperViewModel.deleteGameFavorite()
                    self.isFavorite = !removed
                    self.gameFavoriteDetailViewModel.fetchGameFavoriteDetail(gameId: Int32(self.gameId)!)
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

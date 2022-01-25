//
//  GameFavoriteListView.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import SwiftUI

struct GameFavoriteListView: View {
    @ObservedObject private var gameFavoriteListViewModel = LoadGameFavoriteListViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            if gameFavoriteListViewModel.loading {
                LoadingIndicator(color: Color.blue, size: 50)
            } else {
                if (gameFavoriteListViewModel.gameFavorites.count > 0) {
                    List(gameFavoriteListViewModel.gameFavorites, id: \.gameId) { game in
                        ZStack {
                            GameFavoriteItem(game: game)
                            NavigationLink(destination: GameFavoriteDetailView(gameId: "\(game.gameId)", backgroundImage: "\(game.gameBackgroundImage)")) {
                                EmptyView()
                            }.opacity(0)
                        }
                    }
                } else {
                    ErrorView(text: "Games")
                }
            }
        }.onAppear {
            self.gameFavoriteListViewModel.fetchAllGameFavorite()
        }
    }
}

struct GameFavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        GameFavoriteListView()
    }
}

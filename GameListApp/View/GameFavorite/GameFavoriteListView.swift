//
//  GameFavoriteListView.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import SwiftUI

struct GameFavoriteListView: View {
    @ObservedObject private var gameFavoriteListViewModel = GameFavoriteListViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            if gameFavoriteListViewModel.loading {
                LoadingIndicator(color: Color.blue, size: 50)
            } else {
                if (gameFavoriteListViewModel.gameFavorites.count > 0) {
                    List(gameFavoriteListViewModel.gameFavorites, id: \.id) { game in
                        ZStack {
                            GameFavoriteItem(viewModel: game)
                            NavigationLink(destination: GameFavoriteDetailView(gameId: "\(game.id)", bgImage: "\(game.backgroundImage)")) {
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

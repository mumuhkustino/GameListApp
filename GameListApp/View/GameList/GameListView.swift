//
//  GameListView.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var gameViewModel = GameListViewModel()
    var body: some View {
        VStack(alignment: .center) {
            if gameViewModel.loading {
                LoadingIndicator(color: Color.blue, size: 50)
            } else {
                if (gameViewModel.games.results.count > 0) {
                    List(gameViewModel.games.results) { game in
                        ZStack {
                            GameItem(game: game)
                            NavigationLink(destination: GameDetailView(gameId: "\(game.id)", backgroundImage: "\(game.backgroundImage)")) {
                                EmptyView()
                            }.opacity(0)
                        }
                    }
                } else {
                    ErrorView(text: "Games")
                }
            }
        }.onAppear {
            self.gameViewModel.loadGameData()
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}

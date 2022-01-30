//
//  LoadGameFavoriteViewModel.swift
//  GameListApp
//
//  Created by C-70 on 22/01/22.
//

import Foundation

class GameFavoriteDetailViewModel: ObservableObject {
    
    @Published
    var gameFavorite  = GameFavorite(id: 0, name: "", rating: 0.0, released: "", desc: "", backgroundImage: "", backgroundImageAdditional: "")
    @Published var loading: Bool = false
    
    func fetchGameFavoriteDetail(gameId: Int32) {
        self.loading = true
        PersistenceController.controllerHelper.selectGameFavoriteDetail(gameId) {
            gameFavorite in
            self.loading = false
            guard let gameFavorite = gameFavorite else {
                return
            }
            self.gameFavorite = gameFavorite
        }
    }
}

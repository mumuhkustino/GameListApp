//
//  LoadGameFavoriteViewModel.swift
//  GameListApp
//
//  Created by C-70 on 22/01/22.
//

import Foundation

class LoadGameFavoriteDetailViewModel: ObservableObject {
    
    @Published
    var gameFavorite  = GameFavorite(gameId: 0, gameName: "", gameRating: 0.0, gameReleased: "", gameDescription: "", gameBackgroundImage: "", gameBackgroundImageAdditional: "")
    @Published var isFavorite: Bool = false
    @Published var loading: Bool = false
    
    func fetchGameFavoriteDetail(gameId: Int32) {
        self.loading = true
        PersistenceController.shared.getGameFavoriteDetail(gameId) {
            gameFavorite in
            self.loading = false
            guard let gameFavorite = gameFavorite else {
                return
            }
            self.gameFavorite = gameFavorite
        }
    }
    
    func changeFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}

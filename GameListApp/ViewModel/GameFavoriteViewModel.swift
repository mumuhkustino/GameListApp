//
//  GameFavoriteViewModel.swift
//  GameListApp
//
//  Created by C-70 on 22/01/22.
//

struct GameFavoriteViewModel {
    var gameFavorite: GameFavoriteLocal
    
    init(gameFavorite: GameFavoriteLocal) {
        self.gameFavorite = gameFavorite
    }
    
    var gameId: Int32 {
        self.gameFavorite.gameId
    }
    
    var gameName: String {
        self.gameFavorite.gameName ?? ""
    }
    
    var gameRating: Float {
        self.gameFavorite.gameRating
    }
    
    var gameReleased: String {
        self.gameFavorite.gameReleased ?? ""
    }
    
    var gameDescription: String {
        self.gameFavorite.gameDescription ?? ""
    }
    
    var gameBackgroundImage: String {
        self.gameFavorite.gameBackgroundImage ?? ""
    }
    
    var gameBackgroundImageAdditional: String {
        self.gameFavorite.gameBackgroundImageAdditional ?? ""
    }
}

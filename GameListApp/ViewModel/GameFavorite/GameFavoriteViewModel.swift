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
    
    var id: Int32 {
        self.gameFavorite.id
    }
    
    var name: String {
        self.gameFavorite.name ?? ""
    }
    
    var rating: Float {
        self.gameFavorite.rating
    }
    
    var released: String {
        self.gameFavorite.released ?? ""
    }
    
    var desc: String {
        self.gameFavorite.desc ?? ""
    }
    
    var backgroundImage: String {
        self.gameFavorite.backgroundImage ?? ""
    }
    
    var backgroundImageAdditional: String {
        self.gameFavorite.backgroundImageAdditional ?? ""
    }
}

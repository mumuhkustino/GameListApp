//
//  AddFavoriteGameViewModel.swift
//  GameListApp
//
//  Created by C-70 on 22/01/22.
//

import Foundation

class AddGameFavoriteViewModel: ObservableObject {
    var gameId: Int32 = 0
    var gameName: String = ""
    var gameRating: Float = 0.0
    var gameReleased: String = ""
    var gameDescription: String = ""
    var gameBackgroundImage: String = ""
    var gameBackgroundImageAdditional: String = ""
    
    private var gameFavoriteLocal: GameFavoriteLocal {
        let gameFavoriteLocal = GameFavoriteLocal(context: PersistenceController.shared.managedObjectContext)
        gameFavoriteLocal.gameId = gameId
        gameFavoriteLocal.gameName = gameName
        gameFavoriteLocal.gameRating = gameRating
        gameFavoriteLocal.gameReleased = gameReleased
        gameFavoriteLocal.gameDescription = gameDescription
        gameFavoriteLocal.gameBackgroundImage = gameBackgroundImage
        gameFavoriteLocal.gameBackgroundImageAdditional = gameBackgroundImageAdditional
        return gameFavoriteLocal
    }
    
    func addGameFavorite() -> Bool {
        do {
            try PersistenceController.shared.addGameFavorite(gameFavorite: gameFavoriteLocal)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}

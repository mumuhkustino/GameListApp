//
//  GameFavoriteDetailHelperViewModel.swift
//  GameListApp
//
//  Created by C-70 on 30/01/22.
//

import Foundation

class GameFavoriteDetailHelperViewModel: ObservableObject {
    var idDelete: Int32 = 0
    var idInsert: Int32 = 0
    var nameInsert: String = ""
    var ratingInsert: Float = 0.0
    var releasedInsert: String = ""
    var descInsert: String = ""
    var backgroundImageInsert: String = ""
    var backgroundImageAdditionalInsert: String = ""
    
    private var gameFavoriteLocal: GameFavoriteLocal {
        let gameFavoriteLocal = GameFavoriteLocal(context: PersistenceController.controllerHelper.managedObjectContext)
        gameFavoriteLocal.id = idInsert
        gameFavoriteLocal.name = nameInsert
        gameFavoriteLocal.rating = ratingInsert
        gameFavoriteLocal.released = releasedInsert
        gameFavoriteLocal.desc = descInsert
        gameFavoriteLocal.backgroundImage = backgroundImageInsert
        gameFavoriteLocal.backgroundImageAdditional = backgroundImageAdditionalInsert
        return gameFavoriteLocal
    }
    
    func insertGameFavorite() -> Bool {
        do {
            try PersistenceController.controllerHelper.insertGameFavorite(gameFavorite: gameFavoriteLocal)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func deleteGameFavorite() -> Bool {
        do {
            try PersistenceController.controllerHelper.deleteGameFavorite(id: idDelete)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}

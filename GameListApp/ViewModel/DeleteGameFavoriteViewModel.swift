//
//  DeleteFavoriteGameViewModel.swift
//  GameListApp
//
//  Created by C-70 on 22/01/22.
//

import Foundation

class DeleteGameFavoriteViewModel: ObservableObject {
    var gameId: Int32 = 0
    
    func deleteGameFavorite() -> Bool {
        do {
            try PersistenceController.shared.deleteGameFavorite(gameId: gameId)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}

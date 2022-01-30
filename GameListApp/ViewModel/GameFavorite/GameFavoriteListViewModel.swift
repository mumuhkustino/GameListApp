//
//  LoadGameFavoriteListViewModel.swift
//  GameListApp
//
//  Created by C-70 on 22/01/22.
//

import CoreData

class GameFavoriteListViewModel: ObservableObject {
    
    @Published var gameFavorites = [GameFavoriteViewModel]()
    @Published var loading: Bool = false
    
    init() {
        fetchAllGameFavorite()
    }
    
    func fetchAllGameFavorite() {
        self.loading = true
        DispatchQueue.main.async {
            self.loading = false
            self.gameFavorites = PersistenceController.controllerHelper.selectAllGameFavorite().map(GameFavoriteViewModel.init)
        }
    }
}


//
//  GameListViewModel.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

class GameListViewModel: ObservableObject {
    @Published var games = GameList(count: 0, next: "", results: [])
    @Published var loading = false
    
    let serviceProtocol: ServiceProtocol
    init(serviceProtocol: ServiceProtocol = ServiceApi()) {
        self.serviceProtocol = serviceProtocol
    }
    
    func loadGameData() {
        self.loading = true
        serviceProtocol.fetchGame { games in
            guard let games = games else {
                return
            }
            
            DispatchQueue.main.async {
                self.loading = false
                self.games.results = games
            }
        }
    }
}

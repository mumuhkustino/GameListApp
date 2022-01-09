//
//  GameDetailViewModel.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Combine
import UIKit

class GameDetailViewModel: ObservableObject {
    @Published var gameDetail = GameDetail(id: 0, name: "", rating: 0, released: "", genres: [], publishers: [], description: "", backgroundImage: "", backgroundImageAdditional: "")
    @Published var loading = false
    
    let serviceProtocol: ServiceProtocol
    init(serviceProtocol: ServiceProtocol = ServiceApi()) {
        self.serviceProtocol = serviceProtocol
    }
    
    func loadGameDataById(id: String) {
        self.loading = true
        serviceProtocol.fetchGameById(gameId: id) { gameDetail in
            self.loading = false
            guard let gameDetail = gameDetail else {
                return
            }
            self.gameDetail = gameDetail
        }
    }
}

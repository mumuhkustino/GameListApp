//
//  Game.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

struct Game: Decodable, Identifiable {
    let id: Int
    let name: String
    let rating: Float
    let released: String
    let backgroundImage: String
    let genres: [GameGenre]
}

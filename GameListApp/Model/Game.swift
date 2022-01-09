//
//  Game.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

struct Game: Codable, Identifiable {
    var id: Int
    var name: String
    var rating: Float
    var released: String
    var backgroundImage: String
    var genres: [GameGenre]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case released
        case backgroundImage = "background_image"
        case genres
    }
}

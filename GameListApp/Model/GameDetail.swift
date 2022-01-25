//
//  GameDetail.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

struct GameDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let rating: Float
    let released: String
    let genres: [GameGenre]
    let publishers: [GamePublisher]
    let description: String
    let backgroundImage: String
    let backgroundImageAdditional: String
}

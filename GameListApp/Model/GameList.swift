//
//  GameList.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

struct GameList: Decodable {
    var count: Int
    var next: String
    var results: [Game]
}

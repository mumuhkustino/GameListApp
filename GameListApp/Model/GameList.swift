//
//  GameList.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

struct GameList: Codable {
    var count: Int
    var next: String
    var results: [Game]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case results
    }
}

//
//  GameGenre.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

struct GameGenre: Codable, Identifiable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

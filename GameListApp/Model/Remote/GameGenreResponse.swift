//
//  GameGenreResponse.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import Foundation

struct GameGenreResponse : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

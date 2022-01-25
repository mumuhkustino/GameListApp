//
//  GameResponseList.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import Foundation

struct GameListResponse: Codable {
    let results: [GameResponse]?
    
    struct GameResponse: Codable {
        let id: Int?
        let name: String?
        let released: String?
        let backgroundImage: String?
        let rating: Float?
        let genres: [GameGenreResponse]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case released
            case backgroundImage = "background_image"
            case rating
            case genres
        }
    }
}

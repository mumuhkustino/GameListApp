//
//  GameResponseDetail.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import Foundation

struct GameDetailResponse: Codable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let rating: Float?
    let description: String?
    let genres: [GameGenreResponse]?
    let publishers: [GamePublisherResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case rating
        case description = "description"
        case genres
        case publishers
    }
}

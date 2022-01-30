//
//  GameDetail.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

struct GameDetail: Codable, Identifiable {
    var id: Int
    var name: String
    var rating: Float
    var released: String
    var genres: [GameGenre]
    var publishers: [GamePublisher]
    var description: String
    var backgroundImage: String
    var backgroundImageAdditional: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case released
        case genres
        case publishers
        case description = "description"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
    }
}

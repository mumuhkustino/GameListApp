//
//  ServiceApi.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

class ServiceApi: ServiceProtocol {
    // Reference https://peterfriese.dev/reading-api-keys-from-plist-files/
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "RAWGIO-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'RAWGIO-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'RAWGIO-Info.plist'.")
        }
        // 3
        if (value.starts(with: "_")) {
          fatalError("Register for a RAWGIO developer account and get an API key at https://rawg.io/apidocs.")
        }
        return value
      }
    }
    
    func fetchGame(completion: @escaping ([Game]?) -> Void) {
        guard let url = URL(string: "\(baseUrl)games?key=\(apiKey)&page=1") else {return}
        URLSession.shared.dataTask(with: url) { (data, urlResponse, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(GameListResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            var games: [Game] = []
            game.results?.forEach({ (result) in
                var genres: [GameGenre] = []
                result.genres?.forEach({ (genre) in
                    genres.append(GameGenre(id: Int32(genre.id ?? 0),
                                            name: genre.name ?? ""
                                           ))
                })
                games.append(Game(
                    id: result.id ?? 0,
                    name: result.name ?? "",
                    rating: result.rating ?? 0.0, released: result.released ?? "",
                    backgroundImage: result.backgroundImage ?? "Unavailable!",
                    genres: genres
                ))
            })
            
            DispatchQueue.main.async {
                completion(games)
            }
        }.resume()
    }
    
    func fetchGameById(gameId: String, completion: @escaping (GameDetail?) -> Void) {
        guard let url = URL(string: "\(baseUrl)games/\(gameId)?key=\(apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { (data, urlResponse, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(GameDetailResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            var publishers: [GamePublisher] = []
            game.publishers?.forEach({ (publisher) in
                publishers.append(GamePublisher(id : Int32(publisher.id ?? 0), name: publisher.name ?? ""))
            })
            
            var genres : [GameGenre] = []
            game.genres?.forEach({ (genre) in
                genres.append(GameGenre(
                    id: Int32(genre.id ?? 0),
                    name: genre.name ?? ""
                ))
            })
            let gameDetail = GameDetail(
                id: game.id ?? 0,
                name: game.name ?? "",
                rating : game.rating ?? 0.0, released : game.released ?? "",
                genres : genres,
                publishers : publishers,
                description : game.description ?? "",
                backgroundImage: game.backgroundImage ?? "Unavailable!",
                backgroundImageAdditional: game.backgroundImageAdditional ?? "Unavailable!"
                )
            
            DispatchQueue.main.async {
                completion(gameDetail)
            }
        }.resume()
    }
}

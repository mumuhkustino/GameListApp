//
//  ServiceApi.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

class ServiceApi: ServiceProtocol {
    func fetchGame(completion: @escaping ([Game]?) -> Void) {
        guard let url = URL(string: "\(baseUrl)games?key=\(apiKey)&page=1") else {return}
        URLSession.shared.dataTask(with: url) { (data, urlResponse, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let games = try? JSONDecoder().decode(GameList.self, from: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(games.results)
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
            guard let games = try? JSONDecoder().decode(GameDetail.self, from: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(games)
            }
        }.resume()
    }
}

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
          fatalError("File does'nt exist 'RAWGIO-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Key does'nt exist 'API_KEY' in 'RAWGIO-Info.plist'.")
        }
        // 3
        if (value.starts(with: "_")) {
          fatalError("Register at https://rawg.io/apidocs.")
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
            guard let games = try? JSONDecoder().decode(GameList.self, from: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(games.results)
            }
        }.resume()
    }
    
    func fetchGameDetail(gameId: String, completion: @escaping (GameDetail?) -> Void) {
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

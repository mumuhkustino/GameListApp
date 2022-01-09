//
//  ServiceProtocol.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import Foundation

protocol ServiceProtocol {
    func fetchGame(completion: @escaping ([Game]?) -> Void)
    func fetchGameById(gameId: String, completion: @escaping (GameDetail?) -> Void)
}

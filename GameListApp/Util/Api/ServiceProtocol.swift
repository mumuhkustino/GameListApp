//
//  ServiceProtocol.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

protocol ServiceProtocol {
    func fetchGame(completion: @escaping ([Game]?) -> Void)
    func fetchGameDetail(gameId: String, completion: @escaping (GameDetail?) -> Void)
}

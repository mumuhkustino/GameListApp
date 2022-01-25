//
//  PersistenceController.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController(managedObjectContext: NSManagedObjectContext.current)
    
    var managedObjectContext: NSManagedObjectContext

    private init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func addGameFavorite(gameFavorite: GameFavoriteLocal) throws {
        self.managedObjectContext.insert(gameFavorite)
        try self.managedObjectContext.save()
    }
    
    func deleteGameFavorite(gameId: Int32) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameFavoriteLocal")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            try self.managedObjectContext.execute(batchDeleteRequest)
//            try self.container.viewContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getGameFavoriteDetail(_ gameId: Int32, completion: @escaping(GameFavorite?) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameFavoriteLocal")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
        
        do {
            if let result = try
//                self.container.viewContext.fetch(fetchRequest).first {
                self.managedObjectContext.fetch(fetchRequest).first {
                let gameFavorite = GameFavorite(gameId: result.value(forKeyPath: "gameId") as? Int32 ?? 0, gameName: result.value(forKeyPath: "gameName") as? String ?? "", gameRating: result.value(forKeyPath: "gameRating") as? Float ?? 0.0, gameReleased: result.value(forKeyPath: "gameReleased") as? String ?? "", gameDescription: result.value(forKey: "gameDescription") as? String ?? "", gameBackgroundImage: result.value(forKeyPath: "gameBackgroundImage") as? String ?? "", gameBackgroundImageAdditional: result.value(forKeyPath: "gameBackgroundImageAdditional") as? String ?? "")
                
                DispatchQueue.main.async {
                    completion(gameFavorite)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getAllGameFavorite() -> [GameFavoriteLocal] {
        var gameFavorite = [GameFavoriteLocal]()
        let postRequest: NSFetchRequest<GameFavoriteLocal> = GameFavoriteLocal.fetchRequest()
        
        do {
//            gameFavorite = try self.container.viewContext.fetch(postRequest)
            gameFavorite = try self.managedObjectContext.fetch(postRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return gameFavorite
    }
}

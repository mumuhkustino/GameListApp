//
//  PersistenceController.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import CoreData

class PersistenceController {
    static let controllerHelper = PersistenceController(managedObjectContext: NSManagedObjectContext.mocCurrent)
    
    var managedObjectContext: NSManagedObjectContext

    private init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func insertGameFavorite(gameFavorite: GameFavoriteLocal) throws {
        self.managedObjectContext.insert(gameFavorite)
        try self.managedObjectContext.save()
    }
    
    func deleteGameFavorite(id: Int32) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameFavoriteLocal")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            try self.managedObjectContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func selectGameFavoriteDetail(_ id: Int32, completion: @escaping(GameFavorite?) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameFavoriteLocal")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        do {
            if let result = try
                self.managedObjectContext.fetch(fetchRequest).first {
                let gameFavorite = GameFavorite(id: result.value(forKeyPath: "id") as? Int32 ?? 0, name: result.value(forKeyPath: "name") as? String ?? "", rating: result.value(forKeyPath: "rating") as? Float ?? 0.0, released: result.value(forKeyPath: "released") as? String ?? "", desc: result.value(forKey: "desc") as? String ?? "", backgroundImage: result.value(forKeyPath: "backgroundImage") as? String ?? "", backgroundImageAdditional: result.value(forKeyPath: "backgroundImageAdditional") as? String ?? "")
                
                DispatchQueue.main.async {
                    completion(gameFavorite)
                }
            }
        } catch let error as NSError {
            print("Fetch Error : \(error), \(error.userInfo)")
        }
    }
    
    func selectAllGameFavorite() -> [GameFavoriteLocal] {
        var gameFavorite = [GameFavoriteLocal]()
        let postRequest: NSFetchRequest<GameFavoriteLocal> = GameFavoriteLocal.fetchRequest()
        
        do {
            gameFavorite = try self.managedObjectContext.fetch(postRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return gameFavorite
    }
}

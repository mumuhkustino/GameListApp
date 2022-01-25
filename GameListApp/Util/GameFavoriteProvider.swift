//
//  GameFavoriteProvider.swift
//  GameListApp
//
//  Created by C-70 on 16/01/22.
//

//import CoreData
//
//class GameFavoriteProvider {
//    lazy var persistentContainer: NSPersistentContainer = {
//            let container = NSPersistentContainer(name: "GameFavorite")
//
//            container.loadPersistentStores { _, error in
//                guard error == nil else {
//                    fatalError("Unresolved error \(error!)")
//                }
//            }
//            container.viewContext.automaticallyMergesChangesFromParent = false
//            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//            container.viewContext.shouldDeleteInaccessibleFaults = true
//            container.viewContext.undoManager = nil
//
//            return container
//        }()
//
//    private func newTaskContext() -> NSManagedObjectContext {
//        let taskContext = persistentContainer.newBackgroundContext()
//        taskContext.undoManager = nil
//
//        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        return taskContext
//    }
//
//    func addGameFavorite(gameFavorite: GameFavorite) throws {
//
//        self.managedObjectContext.insert(gameFavorite)
//        try self.managedObjectContext.save()
//    }
//
//    func deleteFavoriteGame(gameId: Int32) throws {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
//        fetchRequest.fetchLimit = 1
//        fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        batchDeleteRequest.resultType = .resultTypeCount
//        do {
//            try self.managedObjectContext.execute(batchDeleteRequest)
//        } catch let error as NSError {
//            print(error)
//        }
//    }
//
//    func getFavoriteGameById(_ gameId: Int32, completion: @escaping(FavoriteGameModel?) -> ()) {
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
//        fetchRequest.fetchLimit = 1
//        fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
//
//        do {
//            if let result = try self.managedObjectContext.fetch(fetchRequest).first{
//                let favoriteGame = FavoriteGameModel(
//                    gameId: result.value(forKeyPath: "gameId") as? Int32,
//                    gameName: result.value(forKeyPath: "gameName") as? String,
//                    gameRelease: result.value(forKeyPath: "gameRelease") as? String,
//                    gameBackgroundImage: result.value(forKeyPath: "gameBackgroundImage") as? String,
//                    gameBackgroundImageAdditional: result.value(forKeyPath: "gameBackgroundImageAdditional")  as? String,
//                    gameRating: result.value(forKeyPath: "gameRating") as? Float,
//                    gamePlaytime: result.value(forKeyPath: "gamePlaytime") as? Int32,
//                    gameMetacritic: result.value(forKeyPath: "gameMetacritic") as? Int32,
//                    gameDescription: result.value(forKey: "gameDescription") as? String)
//
//                DispatchQueue.main.async {
//                    completion(favoriteGame)
//                }
//
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
//
//    func getAllFavoriteGame() -> [FavoriteGame] {
//
//        var favoriteGame = [FavoriteGame]()
//        let postRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
//
//        do {
//            favoriteGame = try self.managedObjectContext.fetch(postRequest)
//        } catch let error as NSError {
//            print(error)
//        }
//
//        return favoriteGame
//    }
//}

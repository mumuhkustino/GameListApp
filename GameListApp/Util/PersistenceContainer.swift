//
//  PersistenceContainer.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import CoreData

public class PersistenceContainer {
    public static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
    }
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    public static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

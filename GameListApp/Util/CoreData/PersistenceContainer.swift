//
//  PersistenceContainer.swift
//  GameListApp
//
//  Created by C-70 on 23/01/22.
//

import CoreData

public class PersistenceContainer {
    public static var context: NSManagedObjectContext {
        return containerHelper.viewContext
    }
    private init() {
    }
    public static var containerHelper: NSPersistentContainer = {
        let ctr = NSPersistentContainer(name: "GameList 2")
        ctr.loadPersistentStores(completionHandler: { (d, e) in
            if let e = e as NSError? {
                fatalError("Catch Error : \(e), \(e.userInfo)")
            }
        })
        return ctr
    }()
    
    public static func saveContextHelper() {
        let ctx = containerHelper.viewContext
        if ctx.hasChanges {
            do {
                try ctx.save()
            } catch {
                let e = error as NSError
                fatalError("Catch Error : \(e), \(e.userInfo)")
            }
        }
    }
}

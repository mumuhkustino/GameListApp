//
//  GameListAppApp.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI
import CoreData

@main
struct GameListAppApp: App {
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.managedObjectContext)
        }
    }
}

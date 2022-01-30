//
//  GameListAppApp.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

@main
struct GameListAppApp: App {
    let controllerHelper = PersistenceController.controllerHelper
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, controllerHelper.managedObjectContext)
        }
    }
}

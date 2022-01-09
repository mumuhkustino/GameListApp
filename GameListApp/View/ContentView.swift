//
//  ContentView.swift
//  GameListApp
//
//  Created by C-70 on 09/01/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                GameListView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Games")
                }
                AboutView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("About")
                }
            }.navigationBarTitle(Text("Game List App"), displayMode: .inline)
        }
    }
}

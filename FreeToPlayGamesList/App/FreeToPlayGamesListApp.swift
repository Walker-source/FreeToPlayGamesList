//
//  FreeToPlayGamesListApp.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI

@main
struct FreeToPlayGamesListApp: App {
    @StateObject private var gamesVM = GamesViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .environmentObject(gamesVM)
    }
}

//
//  MainView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 24.07.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var games = GamesViewModel()
    
    var body: some View {
        Group {
            if games.isLoading {
                ProgressView("Loading...")
            } else if let error = games.errorMessage {
                Text(error.lowercased())
                    .foregroundStyle(Color.red)
            } else {
                TabView {
                    Tab("Games", systemImage: "list.bullet") {
                        GamesListView(games: games.gamesList)
                    }
                    Tab("Genres", systemImage: "list.bullet.circle") {
                        GenreListView(games: games.gamesList)
                    }
                }
                
            }
            
           
        }
        .task {
            games.fetchGamesList()
        }
    }
}

#Preview {
    MainView()
}

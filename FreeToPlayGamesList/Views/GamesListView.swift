//
//  GameListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI

struct GamesListView: View {
    @StateObject private var gamesList = GamesModel()
    
    var body: some View {
        NavigationStack {
            if gamesList.isLoading {
                ProgressView("Загрузка...")
            } else if let error = gamesList.errorMessage {
                Text(error)
                    .foregroundStyle(Color.red)
            } else {
                List(gamesList.gamesList) { game in
                    HStack {
                        AsyncImage(url: game.thumbnail) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView("Loading")
                        }
                        .frame(width: 150, height: 100)
                        
                        Text(game.title).bold()
                    }
                }
                .navigationTitle(Text("Games"))
            }
        }
        .task {
             gamesList.fetchGamesList()
        }
    }
}

#Preview {
    GamesListView()
}

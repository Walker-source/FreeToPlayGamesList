//
//  GameListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI

struct GamesListView: View {
    @StateObject private var games = GamesViewModel()
    
    
    var body: some View {
        NavigationStack {
            if games.isLoading {
                ProgressView("Загрузка...")
            } else if let error = games.errorMessage {
                Text(error)
                    .foregroundStyle(Color.red)
            } else {
                List(games.gamesList) { game in
                    NavigationLink(destination: GameView(game: game)) {
                        HStack {
                            ThumbnailImageViewModel(
                                url: game.thumbnail,
                                width: ThumbnailCustomization.thumbnailWith,
                                height: ThumbnailCustomization.thumbnailHeight,
                                cornerRadius: ThumbnailCustomization.thumbnailCornerRadius,
                                shadowRadius: ThumbnailCustomization.thumbnailShadowRadius
                            )
                            
                            Text(game.title)
                                .font(.title3)
                                .bold()
                        }
                        .padding(2)
                    }
                }
                .navigationTitle(Text("Games"))
            }
        }
        .task {
             games.fetchGamesList()
        }
    }
}

#Preview {
    GamesListView()
}

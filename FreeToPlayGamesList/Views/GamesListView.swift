//
//  GameListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI

struct GamesListView: View {
    @EnvironmentObject var games: GamesViewModel
    
    @State private var searchText = ""
    
    private var filteredGames: [Game] {
        if searchText.isEmpty {
            return games.gamesList
        } else {
            return games.gamesList.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            if games.gamesList.isEmpty {
                ErrorMessageButtonView(errorMessage: games.errorText) {
                    Task {
                        await games.fetchGamesList()
                    }
                }
            } else {
                List(filteredGames) { game in
                    NavigationLink(destination: GameView(game: game)) {
                        HStack {
                            ThumbnailImageView(
                                width: ThumbnailCustomization.thumbnailWith,
                                height: ThumbnailCustomization.thumbnailHeight,
                                cornerRadius: ThumbnailCustomization.thumbnailCornerRadius,
                                shadowRadius: ThumbnailCustomization.thumbnailShadowRadius,
                                url: game.thumbnail
                            )
                            
                            ListLabelView(gameTitle: game.title)                  }
                        .padding(2)
                    }
                }
                .navigationTitle(Text("Games"))
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search"
                )
                .toolbar {
                    ToolbarItem {
                        ClearCacheButtonView()
                    }
                }
            }
        }
    }
}

#Preview {
    GamesListView()
        .environmentObject(GamesViewModel())
}



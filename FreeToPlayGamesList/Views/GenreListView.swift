//
//  GenreListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 25.07.2025.
//

import SwiftUI

struct GenreListView: View {
    @EnvironmentObject private var games: GamesViewModel
    
    private var groupedGames: [String: [Game]] {
        Dictionary(grouping: games.gamesList, by: {$0.genre})
    }
    private var sortedGenres: [String] {
        groupedGames.keys.sorted()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedGenres, id: \.self) { genre in
                    Section(
                        header: Text(genre)
                            .bold()
                            .font(.subheadline)
                    ) {
                        ForEach(groupedGames[genre] ?? []) { game in
                            NavigationLink(destination: GameView(game: game)) {
                                HStack {
                                    ThumbnailImageViewModel(
                                        width:
                                            ThumbnailCustomization.thumbnailWith,
                                        height:
                                            ThumbnailCustomization.thumbnailHeight,
                                        cornerRadius:
                                            ThumbnailCustomization.thumbnailCornerRadius,
                                        shadowRadius:
                                            ThumbnailCustomization.thumbnailShadowRadius,
                                        url: game.thumbnail
                                    )
                                    
                                    ListLabelViewModel(gameTitle: game.title)
                                }
                                .padding(2)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Genres")
        }
    }
}

#Preview {
    GenreListView()
        .environmentObject(GamesViewModel())
}

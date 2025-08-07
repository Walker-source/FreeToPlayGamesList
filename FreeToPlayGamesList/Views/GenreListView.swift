//
//  GenreListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 25.07.2025.
//

import SwiftUI

struct GenreListView: View {
    @EnvironmentObject private var games: GamesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(games.sortedGenres, id: \.self) { genre in
                    Section(
                        header: Text(genre)
                            .bold()
                            .font(.subheadline)
                    ) {
                        ForEach(games.groupedGames[genre] ?? []) { game in
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

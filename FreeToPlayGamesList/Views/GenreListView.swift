//
//  GenreListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 25.07.2025.
//

import SwiftUI

struct GenreListView: View {
    @EnvironmentObject private var games: GamesViewModel
    
    @State private var genres: [String] = []
    @State private var navigationTitleName = "All genres"
    
    var body: some View {
        Group {
            NavigationStack {
                List {
                    ForEach(genres, id: \.self) { genre in
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
                .navigationTitle(navigationTitleName)
                .toolbar {
                    Menu {
                        Button(action: allGenres) {
                            Text("All")
                        }
                        ForEach(games.sortedGenres, id: \.self) { genre in
                            let buttonName = genre
                            Button(buttonName) {
                                setGenre(genre: buttonName)
                            }
                        }
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                   
                }
            }
        }
        .task {
            genres = games.sortedGenres
        }
        
    }
    
    // MARK: - Private Methods
    private func setGenre(genre: String) {
        genres.removeAll()
        genres.append(genre)
        navigationTitleName = genre
    }
    private func allGenres() {
        genres = games.sortedGenres
        navigationTitleName = "All genres"
    }
}

#Preview {
    GenreListView()
        .environmentObject(GamesViewModel())
}

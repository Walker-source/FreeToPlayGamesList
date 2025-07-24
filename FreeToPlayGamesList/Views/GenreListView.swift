//
//  GenreListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 25.07.2025.
//

import SwiftUI

struct GenreListView: View {
    let games: [Game]
    
    var body: some View {
        NavigationStack {
            List(games) { game in
                Section(
                    header: Text(game.genre)
                ) {
                    HStack {
                        ThumbnailImageViewModel(
                            width: ThumbnailCustomization.thumbnailWith,
                            height: ThumbnailCustomization.thumbnailHeight,
                            cornerRadius: ThumbnailCustomization.thumbnailCornerRadius,
                            shadowRadius: ThumbnailCustomization.thumbnailShadowRadius,
                            url: game.thumbnail
                        )
                        
                        ListLabelViewModel(gameTitle: game.title)
                    }
                    .padding(2)
                }
                
            }
            .navigationTitle("Genres")
        }
    }
}

#Preview {
    GenreListView(games: [Game(
        id: 1,
        title: "TheTestGame",
        thumbnail: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.blog.udonis.co%2Fmobile-marketing%2Fmobile-games%2Ftop-shooter-games&psig=AOvVaw0OT4B1Gy7HYtKXKjmamlg9&ust=1753389974257000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCPDum5nt044DFQAAAAAdAAAAABAE")!,
        shortDescription: "Download and play Shooter games from Epic Games Store. We offer some of the best and most exciting First and Third Person Shooting games to play online, single player or with friends.",
        gameUrl: URL(string: "https://store.epicgames.com/en-US/c/shooter-games?sortBy=releaseDate&sortDir=DESC&count=40")!,
        genre: "Shooter",
        platform: "Windows",
        publisher: "Redish",
        developer: "Redish",
        releaseDate: "20.10.23",
        freetogameProfileUrl: URL(string: "https://store.epicgames.com/en-US/c/shooter-games?sortBy=releaseDate&sortDir=DESC&count=40")!
    )])
}

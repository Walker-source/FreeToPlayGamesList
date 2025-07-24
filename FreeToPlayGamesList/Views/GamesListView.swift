//
//  GameListView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI

struct GamesListView: View {
    let games: [Game]
    
    var body: some View {
        NavigationStack {
            List(games) { game in
                NavigationLink(destination: GameView(game: game)) {
                    HStack {
                        ThumbnailImageViewModel(
                            width: ThumbnailCustomization.thumbnailWith,
                            height: ThumbnailCustomization.thumbnailHeight,
                            cornerRadius: ThumbnailCustomization.thumbnailCornerRadius,
                            shadowRadius: ThumbnailCustomization.thumbnailShadowRadius,
                            url: game.thumbnail
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
}

//#Preview {
//    GamesListView()
//}

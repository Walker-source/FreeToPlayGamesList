//
//  GameDescriptionViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 06.08.2025.
//

import SwiftUI

struct GameDescriptionViewModel: View {
    let game: Game
    
    let descriptionTextSize: CGFloat
    let descriptionTextFrameHeight: CGFloat
    let aboutTextSize: CGFloat
    let aboutTextOpacity: CGFloat
    let descriptionTextBackCorner: CGFloat
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                Rectangle()
                    .frame(height: descriptionTextFrameHeight)
                    .opacity(0.05)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: descriptionTextBackCorner
                        )
                    )
                
                ScrollView {
                    Text(game.shortDescription)
                        .font(
                            .system(
                                size: descriptionTextSize,
                                weight: .bold
                            )
                        )
                }
                .frame(height: descriptionTextFrameHeight)
            }
            
            Text(game.about)
                .font(
                    .system(
                        size: aboutTextSize,
                        weight: .semibold
                    )
                )
                .italic()
                .opacity(aboutTextOpacity)
        }
    }
}

#Preview {
    GameDescriptionViewModel(
        game: Game(
            id: 1,
            title: "TheTestGame",
            thumbnail: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.blog.udonis.co%2Fmobile-marketing%2Fmobile-games%2Ftop-shooter-games&psig=AOvVaw0OT4B1Gy7HYtKXKjmamlg9&ust=1753389974257000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCPDum5nt044DFQAAAAAdAAAAABAE")!,
            shortDescription: "Download and play Shooter games from Epic Games Store. We offer some of the best and most exciting First and Third Person Shooting games to play online, single player or with friends.",
            gameUrl: "https://store.epicgames.com/en-US/c/shooter-games?sortBy=releaseDate&sortDir=DESC&count=40",
            genre: "Shooter",
            platform: "Windows",
            publisher: "Redish",
            developer: "Redish",
            releaseDate: "20.10.23",
            freetogameProfileUrl: "https://store.epicgames.com/en-US/c/shooter-games?sortBy=releaseDate&sortDir=DESC&count=40"
        ),
        descriptionTextSize: GameViewCustomization.descriptionTextSize,
        descriptionTextFrameHeight: GameViewCustomization.descriptionTextFrameHeight,
        aboutTextSize: GameViewCustomization.aboutLabelTextSize,
        aboutTextOpacity: GameViewCustomization.aboutLabelOpacity,
        descriptionTextBackCorner: 15
    )
}

//
//  GameViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI
import Combine

@MainActor
final class GamesViewModel: ObservableObject {
    @Published var gamesList: [Game] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Private Methods
    private func sortGamesByTitle() {
        gamesList.sort { $0.title < $1.title}
    }
    private func fixLowercasedTitle() {
        gamesList = gamesList.map { game in
            var gameModel = game
            var title = game.title
            
            if let firstCharacter = title.first, firstCharacter.isLowercase {
                title.replaceSubrange(
                    title.startIndex...title.startIndex,
                    with: String(firstCharacter).uppercased()
                )
                gameModel.title = title
            }
            return gameModel
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Image) -> Void) {
        networkManager.fetchImage(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else {
                    return
                }
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(_):
                return
            }
        }
    }
    func fetchGamesList() {
        isLoading = true
        
        networkManager.fetchFreeToPlayGamesList(from: networkManager.freeToPlayGamesURL) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let games):
                gamesList = games
                fixLowercasedTitle()
                sortGamesByTitle()
            case .failure(_):
                return
            }
        }
        isLoading = false
    }
}

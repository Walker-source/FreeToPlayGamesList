//
//  NetworkManager.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import SwiftUI

enum NetworkError: Error {
    case noData
    case decodingError
    case httpError(Int)
}

final class NetworkManager {
    let freeToPlayGamesURL = URL(string: "https://www.freetogame.com/api/games?platform=pc")!
    
    static let shared = NetworkManager()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()
    
    private init() {
        configureUrlCache()
    }
    
    // MARK: - Public Methods
    func fetchImage(from url: URL) async throws -> Image {
        let image: Image
        let (data, _) = try await URLSession.shared.data(from: url)
        if let uiImage = UIImage(data: data) {
            image = Image(uiImage: uiImage)
        } else {
            image = Image(systemName: "photo")
        }
        return image
    }
    
    func fetchData(from url: URL) async throws -> [Game] {
        let (data, _) = try await  URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let games = try decoder.decode([Game].self, from: data)
            return games
        } catch {
           throw  NetworkError.decodingError
        }
    }
    
    func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Private Methods
    private func configureUrlCache() {
        let memoryCapacity = 300 * 1024 * 1024
        let diskCapacity = 300 * 1024 * 1024
        
        let cache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: "FTPGImagesCache"
        )
        URLCache.shared = cache
    }
}

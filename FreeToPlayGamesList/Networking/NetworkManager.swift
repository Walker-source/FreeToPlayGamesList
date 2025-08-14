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
    static let shared = NetworkManager()
    let freeToPlayGamesURL = URL(string: "https://www.freetogame.com/api/games?platform=pc")!
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()

    private init() {
        configureUrlCache()
    }
    
    func fetchImage(
        from url: URL,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        session.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.httpError(httpResponse.statusCode)))
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
    func fetchData(
        from url: URL,
        completion: @escaping (Result<[Game], NetworkError>) -> Void
    ) {
        session.dataTask(with: url) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(.httpError(httpResponse.statusCode)))
                    return
                }
                
                guard let data else {
                    DispatchQueue.main.async {
                        completion(.failure(.noData))
                    }
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let game = try decoder.decode([Game].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(game))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
                
            }.resume()
    }
    
    func openLink(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
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

//
//  NetworkManager.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    let freeToPlayGamesURL = URL(string: "https://www.freetogame.com/api/games?platform=pc")!

    private init() {}
    
    func fetchImage(
        from url: URL,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
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
    func fetchFreeToPlayGamesList(
        from url: URL,
        completion: @escaping (Result<[Game], NetworkError>) -> Void
    ) {
        URLSession.shared
            .dataTask(with: url) { data, _, error in
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
    func fetchData<T: Decodable> (from url: URL, type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

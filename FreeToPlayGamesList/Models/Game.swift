//
//  Game.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 21.07.2025.
//

import Foundation

struct Game: Decodable, Identifiable {
    let id: Int
    var title: String
    let thumbnail: URL
    let shortDescription: String
    let gameUrl: URL
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileUrl: URL
    
    var about: String {
        """
        Genre: \(genre).
        Platform: \(platform).
        Publisher: \(publisher).
        Developer: \(developer).
        Relseas date: \(releaseDate).
        """
    }
}

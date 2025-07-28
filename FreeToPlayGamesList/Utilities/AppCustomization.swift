//
//  AppCustomization.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 22.07.2025.
//

import Foundation

// MARK: - Thumbnail Properties
final class ThumbnailCustomization {
    static let thumbnailWith: CGFloat = 150
    static let thumbnailHeight: CGFloat = 100
    static let thumbnailCornerRadius: CGFloat = 15
    static let thumbnailShadowRadius: CGFloat = 3
}

// MARK: - Game View Properties
final class GameViewCustomization {
    static let vstackPadding: CGFloat = 15
    
    // MARK: - Thumbnail Properies
    static let thumbnailImageHeight: CGFloat = 200
    static let thumbnailCornerRaduius: CGFloat = 15
    static let thumbnailShadowRaduius: CGFloat = 5
    
    // MARK: - Description Text Properties
    static let descriptionTextSize: CGFloat = 20
    static let descriptionTextFrameWidth: CGFloat = 340
    
    // MARK: - Label Properties
    static let aboutLabelTextSize: CGFloat = 15
    static let aboutLabelOpacity: CGFloat = 0.7
}

// MARK: - Game View Button Properties
final class GameViewButtonCustomization {
    static let frameWidth: CGFloat = 150
    static let frameHeight: CGFloat = 50
}

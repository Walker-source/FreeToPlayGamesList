//
//  ImageMemoryCache.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 13.08.2025.
//

import SwiftUI

final class ImageMemoryCache {
    static let shared = NSCache<NSURL, UIImage>()
}

//
//  AsyncImageCached.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 13.08.2025.
//

import SwiftUI

struct AsyncImageCached<Content>: View where Content: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    private let networkManager = NetworkManager.shared
    
    @State private var loadedImage: Image?
    
    init(
        url: URL?,
        scale: CGFloat = 1,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content,
        
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let loadedImage {
            content(.success(loadedImage))
        } else if let url {
            content(.empty)
                .task {
                    loadImage(url: url)
                }
        } else {
            content(.empty)
        }
    }
    
    private func loadImage(url: URL) {
        networkManager.fetchImage(from: url) { result in
            switch result {
            case .success(let uiImage):
                let image = UIImage(data: uiImage)
                loadedImage = Image(uiImage: image ?? UIImage())
            case .failure(_):
                return
            }
        }
    }
}

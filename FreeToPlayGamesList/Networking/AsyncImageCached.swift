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
                    await load(url: url)
                }
        } else {
            content(.empty)
        }
    }
    
    private func load(url: URL) async {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        if let cached = URLCache.shared.cachedResponse(for: request),
           let uiImage = UIImage(data: cached.data) {
            withAnimation(transaction.animation) {
                self.loadedImage = Image(uiImage: uiImage)
            }
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let uiImage = UIImage(data: data) {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                
                withAnimation(transaction.animation) {
                    self.loadedImage = Image(uiImage: uiImage)
                }
            }
        } catch {
            print("Load error", error)
        }
    }
}

//#Preview {
//    AsyncImageCached()
//}

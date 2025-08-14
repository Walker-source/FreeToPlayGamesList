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
    
    private func load(url: URL) async {
        let nsUrl = url as NSURL
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        // Memory Cache
        if let chachedImage = ImageMemoryCache.shared.object(forKey: nsUrl) {
            self.loadedImage = Image(uiImage: chachedImage)
            return
        }
        
        // Cache Check
//        if let cached = URLCache.shared.cachedResponse(for: request),
//           let uiImage = UIImage(data: cached.data) {
//            withAnimation(transaction.animation) {
//                self.loadedImage = Image(uiImage: uiImage)
//            }
//            return
//        }
        
        // Disk Cache
        if let cached = URLCache.shared.cachedResponse(for: request),
           let uiImage = UIImage(data: cached.data) {
            ImageMemoryCache.shared.setObject(uiImage, forKey: nsUrl)
            self.loadedImage = Image(uiImage: uiImage)
            return
        }
        
        // Network Load
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let uiImage = UIImage(data: data) {
                // Save to memory
                ImageMemoryCache.shared.setObject(uiImage, forKey: nsUrl)
                
                // Save to disk
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                
                //Show image
                self.loadedImage = Image(uiImage: uiImage)
//                withAnimation(transaction.animation) {
//                    self.loadedImage = Image(uiImage: uiImage)
//                }
            }
        } catch {
            print("Load error", error)
        }
    }
    private func loadImage(url: URL) {
        networkManager.fetchImage(from: url) { result in
            switch result {
            case .success(let uiImage):
                let image = UIImage(data: uiImage)
                loadedImage = Image(uiImage: image ?? UIImage())
            case .failure(let failure):
                return
            }
        }
    }
}

//#Preview {
//    AsyncImageCached()
//}

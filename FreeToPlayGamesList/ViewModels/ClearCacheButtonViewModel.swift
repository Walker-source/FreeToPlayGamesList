//
//  ClearCacheButtonViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 14.08.2025.
//

import SwiftUI

struct ClearCacheButtonViewModel: View {
    @State private var isPresented = false
    
    var body: some View {
        Button(action: clearCache) {
            Image(systemName: "trash")
                .bold()
        }
        .alert("Cache cleared", isPresented: $isPresented) {
            Button("Dismiss", action: {})
        }
        
    }
    
    private func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        isPresented = true
    }
}

#Preview {
    ClearCacheButtonViewModel()
}

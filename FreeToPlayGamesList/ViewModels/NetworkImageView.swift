//
//  NetworkImageView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 22.07.2025.
//

import SwiftUI

struct NetworkImageView: View {
    let url: URL?
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipped()
            case .failure(let error):
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.gray)
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}

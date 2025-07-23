//
//  ThumbnailImageView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 22.07.2025.
//

import SwiftUI

struct ThumbnailImageViewModel: View {
    let url: URL?
    var width: CGFloat?
    var height: CGFloat?
    var cornerRadius: CGFloat
    var shadowRadius: CGFloat
    
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                    ProgressView("Loading...")
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            case .failure(_):
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
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(radius: shadowRadius)
    }
}

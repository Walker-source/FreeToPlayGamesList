//
//  ButtonViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 28.07.2025.
//

import SwiftUI

struct ButtonViewModel: View {
    let buttonText: String
    let textSize: CGFloat
    
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let cornerRadius: CGFloat
    let shadowRaduis: CGFloat
    
    let url: String
    
    private let networkManager = NetworkManager.shared
    
    var body: some View {
        Button(action: openLink) {
            Text(buttonText)
                .font(.system(size: textSize, weight: .bold))
                .padding(3)
            
        }
        .frame(
            width: frameWidth,
            height: frameHeight
        )
        .foregroundStyle(Color.white)
        .background(Color.gray)
        .cornerRadius(cornerRadius)
        .shadow(radius: shadowRaduis)
    }
    
    private func openLink() {
        networkManager.openLink(urlString: url)
    }
}

#Preview {
    ButtonViewModel(
        buttonText: "Test button",
        textSize: 15,
        frameWidth: 120,
        frameHeight: 50,
        cornerRadius: 10,
        shadowRaduis: 5,
        url: "https://apple.com"
    )
}

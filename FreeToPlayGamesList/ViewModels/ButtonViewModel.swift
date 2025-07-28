//
//  ButtonViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 28.07.2025.
//

import SwiftUI

struct ButtonViewModel: View {
    let buttonText: String
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let url: String
    
    private let networkManager = NetworkManager.shared
    
    var body: some View {
        Button(action: openLink) {
            Text(buttonText)
                .bold()
                .font(.title3)
                .padding(3)
            
        }
        .frame(width: 120, height: 50)
        .foregroundStyle(Color.white)
        .background(Color.gray)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
    
    private func openLink() {
        networkManager.openLink(urlString: url)
    }
}

#Preview {
    ButtonViewModel(
        buttonText: "Test button",
        frameWidth: 120,
        frameHeight: 50,
        url: "https://apple.com"
    )
}

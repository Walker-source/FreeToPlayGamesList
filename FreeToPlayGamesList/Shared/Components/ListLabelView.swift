//
//  ListLabelView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 25.07.2025.
//

import SwiftUI

struct ListLabelView: View {
    let gameTitle: String
    
    var body: some View {
        Text(gameTitle)
            .font(.title3)
            .bold()
    }
}

#Preview {
    ListLabelView(gameTitle: "Test game")
}

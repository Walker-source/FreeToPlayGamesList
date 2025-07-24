//
//  ListLabelViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 25.07.2025.
//

import SwiftUI

struct ListLabelViewModel: View {
    let gameTitle: String
    
    var body: some View {
        Text(gameTitle)
            .font(.title3)
            .bold()
    }
}

#Preview {
    ListLabelViewModel(gameTitle: "Test game")
}

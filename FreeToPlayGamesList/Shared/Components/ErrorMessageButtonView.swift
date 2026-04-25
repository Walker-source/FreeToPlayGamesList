//
//  ErrorMessageButtonView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 26.08.2025.
//

import SwiftUI

struct ErrorMessageButtonView: View {
    let errorMessage: String
    let reload: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text(errorMessage)
            Button(action: reload) {
                Image(systemName: "arrow.trianglehead.clockwise")
                    .font(.title)
            }
        }
    }
}

#Preview {
    ErrorMessageButtonView(errorMessage: "Warning.", reload: {})
}

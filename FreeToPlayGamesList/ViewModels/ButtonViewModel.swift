//
//  ButtonViewModel.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 28.07.2025.
//

import SwiftUI

struct ButtonViewModel: View {
    let buttonText: String
    
    var body: some View {
        Button(action: {}) {
            Text(buttonText)
                .bold()
                .font(.title3)
//                .padding()
                
        }
        .frame(width: 120, height: 50)
        .foregroundStyle(Color.white)
        .background(Color.gray)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

#Preview {
    ButtonViewModel(buttonText: "Test button")
}

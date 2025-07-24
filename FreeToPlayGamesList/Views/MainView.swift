//
//  MainView.swift
//  FreeToPlayGamesList
//
//  Created by Denis Lachikhin on 24.07.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("Games list", systemImage: "list.bullet") {
                GamesListView()
            }
        }
    }
}

#Preview {
    MainView()
}

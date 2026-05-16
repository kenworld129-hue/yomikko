//
//  HomeView.swift
//  yomikko
//
//  Created by kenshun on 2026/05/15.
//

import SwiftUI

struct HomeView: View {
    @Environment(AppRouter.self) var router

    var body: some View {
        VStack {
            Button("はじめる") {
                withAnimation {
                    router.currentScreen = .game
                }
            }
            Button("登録") {
                withAnimation {
                    router.currentScreen = .register
                }
            }
        }
        .transition(.opacity)
    }

}

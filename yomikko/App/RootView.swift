//
//  RootView.swift
//  yomikko
//
//  Created by kenshun on 2026/04/21.
//

import SwiftUI

struct RootView: View {
    @Environment(AppRouter.self) var router

    var body: some View {
        @Bindable var router = router
        Group {
            switch router.currentScreen {
            case .home:
                VStack {
                    HomeView()
                }
                .transition(.opacity)
            case .game:
                VStack {
                    GameView()
                    Button("go to home") {
                        withAnimation {
                            router.currentScreen = .home
                        }
                    }
                }
                .transition(.opacity)
            case .register:
                VStack {
                    RegisterView()
                }
                .transition(.opacity)
            }
        }
        .fullScreenCover(isPresented: $router.isDisclaimerPresented) {
            DisclaimerView()
        }
    }
}

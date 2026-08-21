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
        Group {
            if router.isDisclaimerPresented {
                DisclaimerView()
                    .transition(.opacity)
            } else {
                switch router.currentScreen {
                case .home:
                    VStack {
                        HomeView()
                    }
                    .transition(.opacity)
                case .game:
                    VStack {
                        GameView()
                            .id(router.gameSessionID)
                    }
                    .transition(.opacity)
                case .register:
                    VStack {
                        RegisterView()
                    }
                    .transition(.opacity)
                }

            }
        }
    }
}

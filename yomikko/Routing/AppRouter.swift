//
//  AppRouter.swift
//  yomikko
//
//  Created by kenshun on 2026/05/15.
//
import Observation

@Observable
final class AppRouter {
    var currentScreen: Screen = .home
    var isDisclaimerPresented: Bool = true
    private(set) var gameSessionID = 0

    func startGame() {
        gameSessionID += 1
        currentScreen = .game
    }

    enum Screen {
        case home
        case game
        case register
    }
}

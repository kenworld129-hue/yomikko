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
    enum Screen {
        case home
        case game
        case register
    }
}

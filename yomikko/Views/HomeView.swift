//
//  HomeView.swift
//  yomikko
//
//  Created by kenshun on 2026/05/15.
//

import SwiftUI

struct HomeView: View {
    @Environment(AppRouter.self) var router

    @State private var appeared = false

    private let mascotSize: CGFloat = 200
    private let floatAmplitude: CGFloat = 5
    private let floatDuration = 0.8
    private let titleSpacing: CGFloat = 16
    private let buttonSpacing: CGFloat = 32
    private let registerBottomPadding: CGFloat = 16

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("よみっこ")
                .font(.app(.appTitle))
                .foregroundStyle(AppTheme.keyColor)
            CharacterView(isSpeaking: false)
                .frame(width: mascotSize, height: mascotSize)
                .padding(.top, titleSpacing)
                .offset(y: appeared ? -floatAmplitude : floatAmplitude)
                .animation(
                    .easeInOut(duration: floatDuration).repeatForever(autoreverses: true),
                    value: appeared
                )
            Button("はじめる") {
                withAnimation {
                    router.startGame()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, buttonSpacing)
            Spacer()
            Button {
                withAnimation{
                    router.currentScreen = .register
                }
            } label: {
                Text("登録")
                .font(.app(.body))
                .padding(.vertical, 12)
                .padding(.horizontal, 32)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .strokeBorder(AppTheme.keyColor, lineWidth: 2)
                )
                .contentShape(Rectangle())
            }
            .padding(.bottom, registerBottomPadding)
        }
        .transition(.opacity)
        .onAppear {
            appeared = true
        }
    }

}

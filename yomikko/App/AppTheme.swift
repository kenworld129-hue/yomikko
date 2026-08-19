//
//  AppTheme.swift
//  yomikko
//
//  Created by kenshun on 2026/08/17.
//
import SwiftUI

// アプリ共通の装飾トーン。色・角丸・主ボタン様式はここから引く。
enum AppTheme {
    static let keyColor = Color(red: 93 / 255, green: 173 / 255, blue: 226 / 255)
    static let cornerRadius: CGFloat = 16
}

// 子供が押す主ボタン（結果「おわる」・ホーム2ボタン）の共通様式。
// キーカラー塗り＋白文字＝アプリアイコンと同型。押下中は少し縮んで手応えを返す。
struct PrimaryButtonStyle: ButtonStyle {
    private static let verticalPadding: CGFloat = 16
    private static let horizontalPadding: CGFloat = 48
    private static let pressedScale = 0.95

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
         .font(.app(.primaryButton))
         .foregroundStyle(.white)
         .padding(.vertical, PrimaryButtonStyle.verticalPadding)
         .padding(.horizontal, PrimaryButtonStyle.horizontalPadding)
         .background(
             RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
              .fill(AppTheme.keyColor)
              .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
         )
         .scaleEffect(configuration.isPressed ? PrimaryButtonStyle.pressedScale : 1)
         .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

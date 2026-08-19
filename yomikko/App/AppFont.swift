//
//  AppFont.swift
//  yomikko
//
//  Created by kenshun on 2026/08/17.
//

import SwiftUI

extension Font {

    // 文字の「役割」。View側はptを直書きせず、必ず役割名で指定する。
    // サイズ・太さ・追従方針の調整は本ファイルのswitchだけを触る。
    enum AppRole {
        case card // 単語カード（ゲーム・特大）
        case display // 結果のスコア行（ゲーム・大）
        case displaySub // 結果のお祝い文言（displayの従属行・ゲーム・中）
        case primaryButton // 主ボタン：ホーム２つ・結果「おわる」（ゲーム動線・中大）
        case body // 登録系の本文・フォーム（親向け・端末設定に追従）
        case caption // 登録系の注記・キャプション（親向け・端末設定に追従）
        case gameCaption // ゲーム内の小さな注記（現在地表示など・固定）
    }

    private static let zenMaruBold = "ZenMaruGothic-Bold"
    private static let zenMaruRegular = "ZenMaruGothic-Regular"

    static func app(_ role: AppRole) -> Font {
        switch role {
            case .card:
            return .custom(zenMaruBold, fixedSize: 30)
            case .display:
            return .custom(zenMaruBold, fixedSize: 32)
            case .displaySub:
            return .custom(zenMaruBold, fixedSize: 22)
            case .primaryButton:
            return .custom(zenMaruBold, fixedSize: 26)
            case .body:
            return .custom(zenMaruRegular, size: 17, relativeTo: .body)
            case .caption:
            return .custom(zenMaruRegular, size: 13, relativeTo: .caption)
            case .gameCaption:
            return .custom(zenMaruRegular, fixedSize: 13)
        }
    }
}

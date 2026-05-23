//
//  DisclaimerView.swift
//  yomikko
//
//  Created by kenshun on 2026/05/23.
//

import SwiftUI

struct DisclaimerView: View {
    @Environment(AppRouter.self) var router

    var body: some View {
        VStack(spacing: 64) {
            Text("保護者の方へ")
                .font(.headline)
            ScrollView {
                Text(
                    """
                    「よみっこ」は、お子さまがひらがなの「読み」に楽しく親しむためのアプリです。

                    ひらがなを読む力の育ち方には個人差があり、本アプリだけで読みが身につくことを保証するものではありません。

                    絵本の読み聞かせや日々の語りかけなど、ふだんの関わりとあわせて、学びのきっかけのひとつとしてご活用ください。
                    """
                )
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .padding()

            }
            Button("OK") {
                router.isDisclaimerPresented = false
            }
        }
        .padding()
    }

}

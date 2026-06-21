//
//  GameView.swift
//  yomikko
//
//  Created by kenshun on 2026/06/21.
//
import SwiftUI

struct GameView: View {
    let question = Question(
        imageSource: .asset(name: "inu"),
        options: ["いぬ", "ねこ", "くるま"],
        correctIndex: 0
    )

    var body: some View {
        VStack {
            WordImageView(source: question.imageSource)
                .frame(width: 240, height: 240)
                .clipped()
            HStack {
                ForEach(question.options.indices, id: \.self) { index in
                    WordCardView(reading: question.options[index])
                }
            }
        }
    }
}

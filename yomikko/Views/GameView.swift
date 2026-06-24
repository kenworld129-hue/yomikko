//
//  GameView.swift
//  yomikko
//
//  Created by kenshun on 2026/06/21.
//
import SwiftData
import SwiftUI

struct GameView: View {
    @Query private var words: [Word]
    @State private var session = GameSession()

    var body: some View {
        VStack {
            if let question = session.currentQuestion {
                WordImageView(source: question.imageSource)
                    .frame(width: 240, height: 240)
                    .clipped()
                HStack {
                    ForEach(question.options.indices, id: \.self) { index in
                        WordCardView(reading: question.options[index])
                    }
                }
                Button("つぎへ") {
                    session.advance()
                }
            } else if session.isFinished {
                Text("ぜんぶおわったよ")
            } else {
                EmptyView()
            }
        }
        .onAppear {
            session.start(words: words)
        }
    }
}

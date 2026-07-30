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
    @State private var speaker = SpeechReader()
    @State private var soundPlayer = SoundPlayer()
    @State private var isCelebrating = false

    private let celebrationDuration = 2.0
    private let correctCardScale = 1.3
    private let dimmedOpacity = 0.3
    private let markLineWidth: CGFloat = 12

    var body: some View {
        VStack {
            if let question = session.currentQuestion {
                WordImageView(source: question.imageSource)
                    .frame(width: 240, height: 240)
                    .clipped()
                    .overlay {
                        if isCelebrating {
                            Circle()
                                .stroke(Color.red, lineWidth: markLineWidth)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                HStack {
                    ForEach(question.options.indices, id: \.self) { index in
                        WordCardView(reading: question.options[index]) {
                            handleTap(index)
                        }
                        .scaleEffect(
                            isCelebrating && index == question.correctIndex ? correctCardScale : 1
                        )
                        .opacity(
                            isCelebrating && index != question.correctIndex ? dimmedOpacity : 1)
                    }
                }
            } else if session.isFinished {
                Text("ぜんぶおわったよ")
            } else {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            CharacterView(isSpeaking: speaker.isSpeaking)
                .frame(width: 100, height: 100)
                .padding()
        }
        .onAppear {
            session.start(words: words)
            speakCurrent()
        }
        .onChange(of: session.currentIndex) { _, _ in
            speakCurrent()
        }
    }

    private func speakCurrent() {
        guard let question = session.currentQuestion else { return }
        speaker.speak("\(question.options[question.correctIndex])、どれかな？")
    }

    private func handleTap(_ index: Int) {
        guard !isCelebrating else { return }
        guard session.submitAnswer(at: index) else { return }
        speaker.stop()
        soundPlayer.playCorrect()
        withAnimation(.spring) {
            isCelebrating = true
        }
        Task {
            try? await Task.sleep(for: .seconds(celebrationDuration))
            session.advance()
            isCelebrating = false
        }
    }
}

//
//  GameView.swift
//  yomikko
//
//  Created by kenshun on 2026/06/21.
//
import SwiftData
import SwiftUI

struct GameView: View {
    private enum FeedbackPhase: Equatable {
        case idle
        case celebrating
        case wrong(tappedIndex: Int)
    }

    @Environment(AppRouter.self) private var router
    @Query private var words: [Word]
    @State private var session = GameSession()
    @State private var speaker = SpeechReader()
    @State private var soundPlayer = SoundPlayer()
    @State private var feedback: FeedbackPhase = .idle
    @State private var pendingTask: Task<Void, Never>?
    @State private var isQuitConfirmPresented = false

    private let celebrationDuration = 2.0
    private let wrongDuration = 2.0
    private let correctCardScale = 1.3
    private let dimmedOpacity = 0.3
    private let markLineWidth: CGFloat = 12
    private let wrongMarkSize: CGFloat = 60
    private let revealLineWidth: CGFloat = 4
    private let bounceOffsetGentle: CGFloat = 8
    private let bounceOffsetExcited: CGFloat = 14
    private let bounceDuration = 0.35

    private var resultTier: ResultTier? {
        session.isFinished
            ? ResultTier(score: session.score, total: session.questions.count)
            : nil
    }

    private var characterBounceOffset: CGFloat {
        switch resultTier?.bounce {
        case .excited: return bounceOffsetExcited
        case .gentle: return bounceOffsetGentle
        case .still, nil: return 0
        }
    }

    var body: some View {
        VStack {
            if let question = session.currentQuestion {
                WordImageView(source: question.imageSource)
                    .frame(width: 240, height: 240)
                    .overlay {
                        if feedback == .celebrating {
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
                            feedback == .celebrating && index == question.correctIndex
                                ? correctCardScale : 1
                        )
                        .opacity(
                            feedback == .celebrating && index != question.correctIndex
                                ? dimmedOpacity : 1
                        )
                        .overlay {
                            if feedback == .wrong(tappedIndex: index) {
                                Image(systemName: "xmark")
                                    .font(.system(size: wrongMarkSize, weight: .bold))
                                    .foregroundStyle(Color.gray)
                            } else if case .wrong = feedback, index == question.correctIndex {
                                Rectangle()
                                    .strokeBorder(Color.green, lineWidth: revealLineWidth)
                            }
                        }
                    }
                }
            } else if session.isFinished {
                ResultView(score: session.score, total: session.questions.count) {
                    leaveGame()
                }
            } else {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            CharacterView(isSpeaking: speaker.isSpeaking)
                .frame(width: 100, height: 100)
                .padding()
                .offset(y: session.isFinished ? -characterBounceOffset : 0)
                .animation(
                    .easeInOut(duration: bounceDuration).repeatForever(autoreverses: true),
                    value: session.isFinished
                )
        }
        .overlay(alignment: .topLeading) {
            if session.currentQuestion != nil {
                Button("やめる") {
                    isQuitConfirmPresented = true
                }
                .padding()
                .confirmationDialog(
                    "ゲームをやめてホームにもどりますか？",
                    isPresented: $isQuitConfirmPresented,
                    titleVisibility: .visible
                ) {
                    Button("やめる", role: .destructive) {
                        leaveGame()
                    }
                }
            }
        }
        .onAppear {
            session.start(words: words)
            speakCurrent()
        }
        .onChange(of: session.currentIndex) { _, _ in
            speakCurrent()
        }
        .onChange(of: session.isFinished) { _, _ in
            guard let tier = resultTier else { return }
            if tier.playsSound {
                soundPlayer.playCorrect()
            }
            let text = tier.speechText(score: session.score, total: session.questions.count)
            pendingTask = Task {
                try? await Task.sleep(for: .seconds(tier.speechDelay))
                guard !Task.isCancelled else { return }
                speaker.speak(text)
            }
        }
    }

    private func speakCurrent() {
        guard let question = session.currentQuestion else { return }
        speaker.speak("\(question.options[question.correctIndex])、どれかな？")
    }

    private func handleTap(_ index: Int) {
        guard feedback == .idle else { return }
        let isCorrect = session.submitAnswer(at: index)
        speaker.stop()
        if isCorrect {
            soundPlayer.playCorrect()
            withAnimation(.spring) {
                feedback = .celebrating
            }
        } else {
            soundPlayer.playIncorrect()
            feedback = .wrong(tappedIndex: index)
        }
        let duration = isCorrect ? celebrationDuration : wrongDuration
        pendingTask = Task {
            try? await Task.sleep(for: .seconds(duration))
            guard !Task.isCancelled else { return }
            session.advance()
            feedback = .idle
        }
    }

    private func leaveGame() {
        pendingTask?.cancel()
        speaker.stop()
        withAnimation {
            router.currentScreen = .home
        }
    }
}

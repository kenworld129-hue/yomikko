//
//  GameSession.swift
//  yomikko
//
//  Created by kenshun on 2026/06/24.
//

import Observation

@Observable
final class GameSession {
    var questions: [Question] = []
    var currentIndex: Int = 0

    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    var isFinished: Bool {
        !questions.isEmpty && currentIndex >= questions.count
    }

    func start(words: [Word]) {
        questions = QuestionGenerator.makeQuestions(from: words)
        currentIndex = 0
    }

    func advance() {
        currentIndex += 1
    }
}

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
    private(set) var score: Int = 0

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
        score = 0
    }

    func advance() {
        currentIndex += 1
    }

    func submitAnswer(at index: Int) -> Bool {
        guard let question = currentQuestion else { return false }
        let isCorrect = index == question.correctIndex
        if isCorrect {
            score += 1
        }
        return isCorrect
    }
}

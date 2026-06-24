//
//  QuestionGenerator.swift
//  yomikko
//
//  Created by kenshun on 2026/06/23.
//

enum QuestionGenerator {
    static func makeQuestions(from words: [Word]) -> [Question] {
        let correctWords = words.shuffled().prefix(min(10, words.count))

        var questions: [Question] = []

        for correctWord in correctWords {
            var usedReadings: Set<String> = [correctWord.reading]
            var optionWords: [Word] = [correctWord]

            for candidate in words.shuffled() {
                if optionWords.count >= 3 { break }
                if usedReadings.contains(candidate.reading) { continue }
                optionWords.append(candidate)
                usedReadings.insert(candidate.reading)
            }

            let shuffledOptions = optionWords.shuffled()
            let question = Question(
                imageSource: correctWord.imageSource,
                options: shuffledOptions.map { $0.reading },
                correctIndex: shuffledOptions.firstIndex { $0.id == correctWord.id } ?? 0
            )
            questions.append(question)
        }
        return questions
    }
}

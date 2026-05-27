//
//  WordFormView.swift
//  yomikko
//
//  Created by kenshun on 2026/05/25.
//

import SwiftData
import SwiftUI

struct WordFormView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var reading: String
    @State private var errorMessage: String?

    let word: Word?
    let onComplete: () -> Void

    init(word: Word?, onComplete: @escaping () -> Void) {
        self.word = word
        self.onComplete = onComplete
        _reading = State(initialValue: word?.reading ?? "")
        _errorMessage = State(initialValue: nil)
    }

    var body: some View {
        VStack {
            TextField("ひらがなでにゅうりょく", text: $reading)
            Button("写真を選ぶ") {
                //3-4で実装
            }
            Image(systemName: "photo")
            .frame(width: 100, height: 100)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
            }
            Button("保存") {
                save()
            }
            Button("やめる") {
                onComplete()
            }
        }
    }

    private func save() {
        let trimmed = reading.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            errorMessage = "ひらがなを入力してください"
            return
        }
        if trimmed.range(of: "^[ぁ-んー]+$", options: .regularExpression) == nil {
            errorMessage = "ひらがなで入力してください"
            return
        }
        if trimmed.count > Word.Constants.maxLength {
            errorMessage = "\(Word.Constants.maxLength)文字以内で入力してください"
            return
        }
        if word == nil {
            let newWord = Word(reading: trimmed, imagePath: nil, isCustom: true)
            modelContext.insert(newWord)
        } else {
            word?.reading = trimmed

        }
        do {
            try modelContext.save()
        } catch {
            errorMessage = "保存に失敗しました"
            modelContext.rollback()
            return
        }

        onComplete()

    }

}

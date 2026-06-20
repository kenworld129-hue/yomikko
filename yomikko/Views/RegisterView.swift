//
//  RegisterView.swift
//  yomikko
//
//  Created by kenshun on 2026/05/25.
//

import SwiftData
import SwiftUI

struct RegisterView: View {
    @Environment(AppRouter.self) var router
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Word.createdAt) private var words: [Word]
    @State private var mode: FormMode = .list
    @State private var isShowingRestoreConfirmation = false
    @State private var isShowingRestoreCompletion = false

    enum FormMode {
        case list
        case adding
        case editing(Word)
    }

    private var sortedWords: [Word] {
        let presets =
            words
            .filter { $0.isCustom == false }
            .sorted { presetIndex(of: $0) < presetIndex(of: $1) }
        let customs =
            words
            .filter { $0.isCustom }
            .sorted { $0.createdAt < $1.createdAt }
        return presets + customs
    }

    private func presetIndex(of word: Word) -> Int {
        PresetWords.all.firstIndex { $0.reading == word.reading } ?? Int.max
    }

    var body: some View {
        switch mode {
        case .list:
            VStack {
                Button("単語追加") {
                    withAnimation {
                        mode = .adding
                    }
                }
                List {
                    ForEach(sortedWords) { word in
                        Button {
                            withAnimation {
                                mode = .editing(word)
                            }
                        } label: {
                            HStack {
                                WordImageView(source: word.imageSource)
                                    .frame(width: 44, height: 44)
                                    .clipped()
                                Text(word.reading)
                            }
                        }
                    }
                }
                Button("ホームへ") {
                    withAnimation {
                        router.currentScreen = .home
                    }
                }
                Button("初期登録の20単語をもとに戻す", role: .destructive) {
                    isShowingRestoreConfirmation = true
                }
            }
            .confirmationDialog(
                "初期登録の20単語をもとに戻しますか？",
                isPresented: $isShowingRestoreConfirmation,
                titleVisibility: .visible
            ) {
                Button("もとに戻す", role: .destructive) {
                    withAnimation {
                        try? PresetSeeder.restorePresets(context: modelContext)
                    }
                    isShowingRestoreCompletion = true
                }
            } message: {
                Text("編集した内容は上書きされます。")
            }
            .alert("初期登録の20単語をもとに戻しました", isPresented: $isShowingRestoreCompletion) {
                Button("OK") {}
            }
        case .adding:
            WordFormView(
                word: nil
            ) {
                withAnimation {
                    mode = .list
                }
            }
        case .editing(let w):
            WordFormView(
                word: w
            ) {
                withAnimation {
                    mode = .list
                }
            }
        }
    }

}

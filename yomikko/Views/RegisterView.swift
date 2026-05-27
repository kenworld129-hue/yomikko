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
    @Query(sort: \Word.createdAt) private var words: [Word]
    @State private var mode: FormMode = .list

    enum FormMode {
        case list
        case adding
        case editing(Word)
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
                    ForEach(words) { word in
                        Button {
                            withAnimation {
                                mode = .editing(word)
                            }
                        } label: {
                            Text(word.reading)
                        }
                    }
                }
                Button("ホームへ") {
                    withAnimation {
                        router.currentScreen = .home
                    }
                }
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

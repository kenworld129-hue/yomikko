//
//  ContentView.swift
//  yomikko
//
//  Created by kenshun on 2026/04/21.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var words: [Word]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(words) { word in
                    NavigationLink {
                        Text("Word at \(word.reading)")
                    } label: {
                        Text(word.reading)
                    }
                }
                .onDelete(perform: deleteWords)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addWord) {
                        Label("Add Word", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addWord() {
        withAnimation {
            let newWord = Word(reading:"ひらがな", imagePath: nil, isCustom: true)
            modelContext.insert(newWord)
        }
    }

    private func deleteWords(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(words[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Word.self, inMemory: true)
}

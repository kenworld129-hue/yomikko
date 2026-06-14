//
//  WordFormView.swift
//  yomikko
//
//  Created by kenshun on 2026/05/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct WordFormView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var reading: String
    @State private var errorMessage: String?
    @State private var isShowingDeleteConfirmation: Bool = false
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var imageState: FormImageState = .unchanged

    let word: Word?
    let onComplete: () -> Void

    var isPreviewShowingImage: Bool {
        switch imageState {
        case .selected:
            true
        case .removed:
            false
        case .unchanged:
            word?.imagePath != nil
        }
    }

    var totalWordCount: Int {
        let descriptor = FetchDescriptor<Word>()
        return (try? modelContext.fetchCount(descriptor)) ?? 0
    }

    enum FormImageState {
        case selected(Data)
        case removed
        case unchanged
    }

    init(word: Word?, onComplete: @escaping () -> Void) {
        self.word = word
        self.onComplete = onComplete
        _reading = State(initialValue: word?.reading ?? "")
        _errorMessage = State(initialValue: nil)
    }

    var body: some View {
        let isBelowMinimum = totalWordCount <= Word.Constants.minWordCount
        VStack {
            TextField("ひらがなでにゅうりょく", text: $reading)
            PhotosPicker(
                selection: $selectedPickerItem,
                matching: .images
            ) {
                Text("画像を選ぶ")
            }
            .onChange(of: selectedPickerItem) {
                Task {
                    guard let item = selectedPickerItem,
                        let raw = try? await item.loadTransferable(type: Data.self),
                        let ui = UIImage(data: raw),
                        let thumb = await ui.byPreparingThumbnail(
                            ofSize: CGSize(
                                width: Word.Constants.imageMaxSize,
                                height: Word.Constants.imageMaxSize)),
                        let jpeg = thumb.jpegData(
                            compressionQuality: Word.Constants.imageJpegQuality)
                    else { return }
                    imageState = .selected(jpeg)
                }
            }
            previewImage
                .frame(width: 100, height: 100)
                .overlay(alignment: .topTrailing) {
                    if isPreviewShowingImage {
                        Button {
                            imageState = .removed
                            selectedPickerItem = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }

            if let errorMessage = errorMessage {
                Text(errorMessage)
            }
            Button("保存") {
                save()
            }
            Button("やめる") {
                onComplete()
            }
            if word != nil {
                Button("この単語を削除", role: .destructive) {
                    isShowingDeleteConfirmation = true
                }
                .disabled(isBelowMinimum)
                if isBelowMinimum {
                    Text("単語は\(Word.Constants.minWordCount)語以上必要なため、削除できません。")
                }
            }
        }
        .confirmationDialog(
            "\(word?.reading ?? "")を削除しますか？", isPresented: $isShowingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("削除", role: .destructive) {
                delete()
            }
            Button("キャンセル", role: .cancel) {}
        }
    }

    @ViewBuilder
    private var previewImage: some View {
        switch imageState {
        case .selected(let data):
            Image(uiImage: UIImage(data: data) ?? UIImage())
                .resizable()
                .scaledToFit()
        case .removed:
            Image(systemName: "photo")
        case .unchanged:
            if let path = word?.imagePath {
                if path.hasPrefix(Word.Constants.imageAssetPrefix) {
                    Image(String(path.dropFirst(Word.Constants.imageAssetPrefix.count)))
                        .resizable().scaledToFit()
                } else if path.hasPrefix(Word.Constants.imageLocalPrefix),
                    let ui = ImageStore.loadImage(
                        forFileName: String(path.dropFirst(Word.Constants.imageLocalPrefix.count)))
                {
                    Image(uiImage: ui).resizable().scaledToFit()
                } else {
                    Image(systemName: "photo")
                }
            } else {
                Image(systemName: "photo")
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

        let oldImagePath = word?.imagePath
        let oldImageSource = word?.imageSource
        let finalImagePath: String?

        switch imageState {
        case .selected(let data):
            let fileName = UUID().uuidString + ".jpg"
            guard let url = ImageStore.documentsFileURL(forFileName: fileName) else {
                errorMessage = "画像の保存に失敗しました"
                return
            }
            do { try data.write(to: url) } catch {
                errorMessage = "画像の保存に失敗しました"
                return
            }
            finalImagePath = Word.Constants.imageLocalPrefix + fileName
        case .removed:
            finalImagePath = nil
        case .unchanged:
            finalImagePath = oldImagePath
        }
        if word == nil {
            let newWord = Word(reading: trimmed, imagePath: finalImagePath, isCustom: true)
            modelContext.insert(newWord)
        } else {
            word?.reading = trimmed
            word?.imagePath = finalImagePath
        }
        do {
            try modelContext.save()
        } catch {
            errorMessage = "保存に失敗しました"
            modelContext.rollback()
            return
        }

        switch imageState {
        case .selected, .removed:
            if let source = oldImageSource, case .local(let fileName) = source {
                ImageStore.deleteImage(forFileName: fileName)
            }
        case .unchanged:
            break
        }

        onComplete()
    }

    private func delete() {
        guard let word = word else {
            return
        }
        let source = word.imageSource
        modelContext.delete(word)
        do {
            try modelContext.save()
        } catch {
            errorMessage = "削除に失敗しました"
            modelContext.rollback()
            return
        }
        if case .local(let fileName) = source {
            ImageStore.deleteImage(forFileName: fileName)
        }
        onComplete()
    }

}

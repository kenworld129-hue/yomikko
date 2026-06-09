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
            if let old = oldImagePath, old.hasPrefix(Word.Constants.imageLocalPrefix),
                let url = ImageStore.documentsFileURL(
                    forFileName: String(old.dropFirst(Word.Constants.imageLocalPrefix.count)))
            {
                try? FileManager.default.removeItem(at: url)
            }
        case .unchanged:
            break
        }

        onComplete()

    }

}

//
//  PresetSeeder.swift
//  yomikko
//
//  Created by kenshun on 2026/05/13.
//

import Foundation
import SwiftData

enum PresetWords {
    static let all: [(reading: String, imageAssetName: String)] = [
        (reading: "いぬ", imageAssetName: "inu"),
        (reading: "ねこ", imageAssetName: "neko"),
        (reading: "くるま", imageAssetName: "kuruma"),
        (reading: "でんしゃ", imageAssetName: "densha"),
        (reading: "りんご", imageAssetName: "ringo"),
        (reading: "ばなな", imageAssetName: "banana"),
        (reading: "はな", imageAssetName: "hana"),
        (reading: "ほん", imageAssetName: "hon"),
        (reading: "かばん", imageAssetName: "kaban"),
        (reading: "くつ", imageAssetName: "kutsu"),
        (reading: "ぼーる", imageAssetName: "bouru"),
        (reading: "たいよう", imageAssetName: "taiyou"),
        (reading: "つき", imageAssetName: "tsuki"),
        (reading: "ほし", imageAssetName: "hoshi"),
        (reading: "みず", imageAssetName: "mizu"),
        (reading: "かさ", imageAssetName: "kasa"),
        (reading: "いえ", imageAssetName: "ie"),
        (reading: "きのこ", imageAssetName: "kinoko"),
        (reading: "とり", imageAssetName: "tori"),
        (reading: "さかな", imageAssetName: "sakana"),

    ]
}

enum PresetSeeder {
    static func seedIfNeeded(context: ModelContext) throws {
        let wordCount = try context.fetchCount(FetchDescriptor<Word>())

        guard wordCount == 0 else {
            return
        }

        for presetWord in PresetWords.all {
            let word = Word(
                reading: presetWord.reading,
                imagePath: Word.Constants.imageAssetPrefix + presetWord.imageAssetName,
                isCustom: false)

            context.insert(word)
        }
        try context.save()
    }
    static func restorePresets(context: ModelContext) throws {
        let allWords = try context.fetch(FetchDescriptor<Word>())
        var fileNamesToDelete: [String] = []

        for presetWord in PresetWords.all {
            let assetPath = Word.Constants.imageAssetPrefix + presetWord.imageAssetName
            let match = allWords.filter {
                $0.isCustom == false
                    && ($0.reading == presetWord.reading || $0.imagePath == assetPath)
            }.first
            if let match = match {
                if case .local(let fileName) = match.imageSource {
                    fileNamesToDelete.append(fileName)
                }
                match.reading = presetWord.reading
                match.imagePath = assetPath
            } else {
                let word = Word(
                    reading: presetWord.reading,
                    imagePath: assetPath,
                    isCustom: false)
                context.insert(word)
            }
        }
        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
        for fileName in fileNamesToDelete {
            ImageStore.deleteImage(forFileName: fileName)
        }
    }
}

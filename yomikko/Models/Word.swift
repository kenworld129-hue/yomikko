//
//  Word.swift
//  yomikko
//
//  Created by kenshun on 2026/04/21.
//

import Foundation
import SwiftData

@Model
final class Word {
    @Attribute(.unique)
    var id: UUID

    var reading: String
    var imagePath: String?
    var isCustom: Bool
    var createdAt: Date

    init(
        id: UUID = UUID(), reading: String, imagePath: String?, isCustom: Bool,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.reading = reading
        self.imagePath = imagePath
        self.isCustom = isCustom
        self.createdAt = createdAt
    }
    enum Constants {
        static let maxLength = 10
        static let imageMaxSize: CGFloat = 1024
        static let imageJpegQuality: CGFloat = 0.8
        static let imageAssetPrefix = "asset:"
        static let imageLocalPrefix = "local:"
    }
    enum ImageSource {
        case asset(name: String)
        case local(fileName: String)
        case none
    }
    var imageSource: ImageSource {
        switch imagePath {
        case let path? where path.hasPrefix(Constants.imageAssetPrefix):
            ImageSource.asset(name: String(path.dropFirst(Constants.imageAssetPrefix.count)))
        case let path? where path.hasPrefix(Constants.imageLocalPrefix):
            ImageSource.local(fileName: String(path.dropFirst(Constants.imageLocalPrefix.count)))
        case nil:
            ImageSource.none
        default:
            ImageSource.none

        }
    }

}

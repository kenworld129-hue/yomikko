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
    
    init(id: UUID = UUID(), reading: String, imagePath: String?, isCustom: Bool, createdAt: Date = Date()) {
        self.id = id
        self.reading = reading
        self.imagePath = imagePath
        self.isCustom = isCustom
        self.createdAt = createdAt
    }
}

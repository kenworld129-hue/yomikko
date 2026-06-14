//
//  ImageStore.swift
//  yomikko
//
//  Created by kenshun on 2026/06/07.
//

import UIKit

enum ImageStore {
    static func documentsFileURL(forFileName fileName: String) -> URL? {
        guard
            let docs = FileManager.default.urls(
                for: .documentDirectory, in: .userDomainMask
            ).first
        else {
            return nil
        }
        return docs.appendingPathComponent(fileName)
    }

    static func loadImage(forFileName fileName: String) -> UIImage? {
        guard let url = documentsFileURL(forFileName: fileName) else {
            return nil
        }
        let ui = UIImage(contentsOfFile: url.path)
        return ui
    }

    static func deleteImage(forFileName fileName: String) {
        guard let url = documentsFileURL(forFileName: fileName) else {
            return
        }
        try? FileManager.default.removeItem(at: url)
    }
}

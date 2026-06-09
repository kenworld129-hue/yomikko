//
//  WordImageView.swift
//  yomikko
//
//  Created by kenshun on 2026/06/08.
//

import SwiftUI
import UIKit

struct WordImageView: View {
    let source: Word.ImageSource
    var body: some View {
        switch source {
        case .asset(let name):
            Image(name)
                .resizable()
                .scaledToFill()
        case .local(let filename):
            if let ui = ImageStore.loadImage(forFileName: filename) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else {
                Image("fallback")
                    .resizable()
                    .scaledToFill()
            }
        case .none:
            Image("fallback")
                .resizable()
                .scaledToFill()
        }

    }
}

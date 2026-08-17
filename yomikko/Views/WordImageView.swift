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
                .scaledToFit()
        case .local(let filename):
            if let ui = ImageStore.loadImage(forFileName: filename) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFit()
            } else {
                Image("fallback")
                    .resizable()
                    .scaledToFit()
            }
        case .none:
            Image("fallback")
                .resizable()
                .scaledToFit()
        }

    }
}

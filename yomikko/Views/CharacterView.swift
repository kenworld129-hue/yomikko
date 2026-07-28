//
//  CharacterView.swift
//  yomikko
//
//  Created by kenshun on 2026/07/26.
//

import SwiftUI

struct CharacterView: View {
    let isSpeaking: Bool

    private let flipInterval = 0.25

    var body: some View {
        TimelineView(.animation(minimumInterval: flipInterval, paused: !isSpeaking)) { context in
            let tick = Int(context.date.timeIntervalSinceReferenceDate / flipInterval)
            let isOpen = isSpeaking && tick % 2 == 0
            Image(isOpen ? "mascot_open" : "mascot_closed")
                .resizable()
                .scaledToFit()
        }
    }
}

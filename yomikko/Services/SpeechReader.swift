//
//  SpeechReader.swift
//  yomikko
//
//  Created by kenshun on 2026/6/27.
//
//

import AVFoundation

final class SpeechReader {
    private let synthesizer = AVSpeechSynthesizer()
    private let pitch: Float = 1.0
    private let voice: AVSpeechSynthesisVoice? = {
        let preferredIdentifiers = [
            "com.apple.ttsbundle.siri_O-ren_ja-JP_compact",
            "com.apple.eloquence.ja-JP.Grandma",
        ]
        for identifier in preferredIdentifiers {
            if let voice = AVSpeechSynthesisVoice(identifier: identifier) {
                return voice
            }
        }
        return AVSpeechSynthesisVoice(language: "ja-JP")
    }()

    func speak(_ text: String) {
        synthesizer.stopSpeaking(at: .immediate)

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        utterance.rate = 0.4
        utterance.pitchMultiplier = pitch

        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}

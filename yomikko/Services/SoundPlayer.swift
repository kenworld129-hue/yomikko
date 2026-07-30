//
//  SoundPlayer.swift
//  yomikko
//
//  Created by kenshun on 2026/07/30.
//
import AVFoundation

final class SoundPlayer {
    private let correctPlayer: AVAudioPlayer? = SoundPlayer.makePlayer(forResource: "correct")

    func playCorrect() {
        guard let player = correctPlayer else { return }
        player.currentTime = 0
        player.play()
    }

    private static func makePlayer(forResource name: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return nil
        }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        return player
    }
}

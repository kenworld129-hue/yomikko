//
//  ConfettiView.swift
//  yomikko
//
//  Created by kenshun on 2026/08/16.
//

import SwiftUI

struct ConfettiView: View {
    private struct Piece: Identifiable {
        let id = UUID()
        let relativeX: CGFloat
        let size: CGFloat
        let color: Color
        let duration: Double
        let delay: Double
        let spin: Double
    }

    private static let palette: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    private static let sizeRange: ClosedRange<CGFloat> = 6...12
    private static let aspectRatio: CGFloat = 0.6
    private static let durationRange: ClosedRange<Double> = 2.0...3.5
    private static let delayRange: ClosedRange<Double> = 0...0.8
    private static let spinRange: ClosedRange<Double> = 360...1080

    @State private var pieces: [Piece]
    @State private var isFalling = false

    init(count: Int) {
        _pieces = State(initialValue: ConfettiView.makePieces(count: count))
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(pieces) { piece in
                Rectangle()
                .fill(piece.color)
                .frame(width: piece.size, height: piece.size * ConfettiView.aspectRatio)
                .rotationEffect(.degrees(isFalling ? piece.spin : 0))
                .position(
                    x: piece.relativeX * geometry.size.width,
                    y: isFalling ? geometry.size.height + piece.size : -piece.size
                )
                .animation(
                    .linear(duration: piece.duration).delay(piece.delay),
                    value: isFalling
                )
            }
        }
        .allowsHitTesting(false)
        .onAppear{
            isFalling = true
        }
    }

    private static func makePieces(count: Int) -> [Piece] {
        (0..<count).map { _ in
            Piece(
                relativeX: CGFloat.random(in: 0...1),
                size: CGFloat.random(in: sizeRange),
                color: palette.randomElement() ?? .red,
                duration: Double.random(in: durationRange),
                delay: Double.random(in: delayRange),
                spin: Double.random(in: spinRange) * (Bool.random() ? 1 : -1)
            )
        }
    }
}

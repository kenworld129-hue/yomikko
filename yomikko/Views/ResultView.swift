//
//  ResultView.swift
//  yomikko
//
//  Created by kenshun on 2026/08/16.
//

import SwiftUI

enum ResultTier {
    case perfect
    case high
    case middle
    case low

    static let highThreshold = 8
    static let middleThreshold = 1
    static let confettiCountPerfect = 60
    static let confettiCountHigh = 30
    static let speechDelayAfterSound = 1.8
    static let speechDelayQuiet = 0.5

    enum Bounce {
        case still
        case gentle
        case excited
    }

    init(score: Int, total: Int) {
        if score == total {
            self = .perfect
        } else if score >= ResultTier.highThreshold {
            self = .high
        } else if score >= ResultTier.middleThreshold {
            self = .middle
        } else {
            self = .low
        }
    }

    var subMessage: String {
        switch self {
            case .perfect: return "ぜんぶ　せいかい！すごーい！"
            case .high: return "すごい！"
            case .middle: return "がんばったね！"
            case .low : return "ざんねん　つぎがんばろうね"
        }
    }

    var confettiCount: Int {
        switch self {
            case .perfect: return ResultTier.confettiCountPerfect
            case .high: return ResultTier.confettiCountHigh
            case .middle, .low: return 0
        }
    }

    var bounce: Bounce {
        switch self {
            case .perfect: return .excited
            case .high: return .gentle
            case .middle, .low: return .still
        }
    }

    var playsSound: Bool {
        self != .low
    }

    var speechDelay: Double {
        playsSound ? ResultTier.speechDelayAfterSound : ResultTier.speechDelayQuiet
    }

    func scoreLine(score: Int, total: Int) -> String {
        let base = "\(total)もんちゅう\n\(score)もんせいかい"
        return self == .low ? base : base + "！"
    }

    func speechText(score: Int, total: Int) -> String {
        self == .low ? subMessage : scoreLine(score: score, total: total) + subMessage
    }
}

struct ResultView: View {
    let score: Int
    let total: Int
    let onFinish: () -> Void

    @State private var appeared = false

    private let stampSize: CGFloat = 28
    private let stampLineWidth: CGFloat = 5
    private let stampSpacing: CGFloat = 6
    private let stampInterval = 0.15
    private let quietFadeDuration = 0.6

    private var tier: ResultTier {
        ResultTier(score: score, total: total)
    }

    var body: some View {
        VStack(spacing: 24) {
            if score > 0 {
                HStack(spacing: stampSpacing) {
                    ForEach(0..<score, id: \.self) { index in
                        Circle()
                        .stroke(Color.red, lineWidth: stampLineWidth)
                        .frame(width: stampSize, height: stampSize)
                        .scaleEffect(appeared ? 1 : 0)
                        .animation(
                            .spring.delay(Double(index) * stampInterval),
                            value: appeared
                        )
                    }
                }
            }
            VStack(spacing: 8) {
                Text(tier.scoreLine(score: score, total: total))
                    .font(.app(.display))
                    .multilineTextAlignment(.center)
                Text(tier.subMessage)
                    .font(.app(.displaySub))
            }
            .scaleEffect((appeared || tier == .low) ? 1 : 0)
            .opacity(appeared ? 1 : 0)
            .animation(
                tier == .low ? .easeIn(duration: quietFadeDuration) : .spring,
                value: appeared
            )
            Button("おわる") {
                onFinish()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if tier.confettiCount > 0 {
                ConfettiView(count: tier.confettiCount)
            }
        }
        .onAppear {
            appeared = true
        }
    }
}

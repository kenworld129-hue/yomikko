//
//  WordCardView.swift
//  yomikko
//
//  Created by kenshun on 2026/06/21.
//

import SwiftUI

struct WordCardView: View {
    let reading: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(reading)
                .font(.app(.card))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .strokeBorder(AppTheme.keyColor, lineWidth: 2.5)
                )
        }
        .buttonStyle(.plain)
    }
}

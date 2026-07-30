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
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
        }
        .buttonStyle(.plain)
    }
}

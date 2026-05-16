//
//  yomikkoApp.swift
//  yomikko
//
//  Created by kenshun on 2026/04/21.
//

import SwiftData
import SwiftUI

@main
struct yomikkoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Word.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var router = AppRouter()

    init() {
        do {
            try PresetSeeder.seedIfNeeded(context: sharedModelContainer.mainContext)
        } catch {
            fatalError("Failed to seed preset words: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
        }
        .modelContainer(sharedModelContainer)
    }
}

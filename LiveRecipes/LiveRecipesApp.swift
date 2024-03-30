//
//  LiveRecipesApp.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/30/24.
//

import SwiftUI

@main
struct LiveRecipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

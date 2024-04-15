//
//  LiveRecipesApp.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 2/20/24.
//

import SwiftUI
import Swinject

extension Container {
    static let sharedContainer: Container = {
        return Container()
    }()
}

extension Assembler {
    static let sharedAssembly: Assembler = {
        return Assembler(
            [
                NetworkServiceAssembly(),
                RecipesAssembly(),
                CookingAssembly(),
                FavoritesAssembly(),
                ListAssembly(),
                OneDishAssembly()
            ], container: Container.sharedContainer
        )
    }()
}

@main
class RootApp: App {
    @ObservedObject var appViewBuilder: ApplicationViewBuilder

    required init() {
        CoreDataManager.shared.prepareCoreDataIfNeeded {}
        self.appViewBuilder = ApplicationViewBuilder()
    }

    var body: some Scene {
        WindowGroup {
            RootView(appViewBuilder: appViewBuilder)
        }
    }
}

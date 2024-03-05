//
//  LiveRecipesApp.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 2/20/24.
//

import SwiftUI

@main
class RootApp: App {

    @ObservedObject var appViewBuilder: ApplicationViewBuilder
    @ObservedObject var navigationService: NavigationService

    let container: DependencyContainer = {
        let factory = AssemblyFactory()
        let container = DependencyContainer(assemblyFactory: factory)

        // Services
        container.apply(NavigationAssembly.self)

        // Modules
        container.apply(RecipesAssembly.self)

        return container
    }()

    required init() {
        navigationService = container.resolve(NavigationAssembly.self).build() as! NavigationService

        appViewBuilder = ApplicationViewBuilder(container: container)
    }

    var body: some Scene {
        WindowGroup {
            RootView(navigationService: navigationService,
                     appViewBuilder: appViewBuilder)
        }
    }
}
